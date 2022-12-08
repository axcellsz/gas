#!/bin/bash
clear
read -rp "Please enter your domain (eg: www.example.com):" domain
GITHUB_CMD="https://github.com/santositb/gas/raw/main/"
INS="apt install -y"
function make_folder_xray() {
    mkdir -p /etc/xray
    mkdir -p /var/log/xray
    chmod +x /var/log/xray
    echo "${domain}" >/etc/xray/domain
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
}

function update_ur_vps() {

    apt update -y
    ${INS} socat cron zip unzip -y

}

function acme() {
    
    rm -rf /root/.acme.sh  >/dev/null 2>&1
    mkdir /root/.acme.sh  >/dev/null 2>&1
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh >/dev/null 2>&1
    chmod +x /root/.acme.sh/acme.sh >/dev/null 2>&1
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade >/dev/null 2>&1
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt >/dev/null 2>&1
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256 >/dev/null 2>&1
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc >/dev/null 2>&1
    
}

function install_xray() {
    ${INS} nginx -y
    curl -s ipinfo.io/city >>/etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 1.6.5 >/dev/null 2>&1
    wget -O /etc/xray/config.json "https://github.com/santositb/gas/raw/main/bagdad/config.json" >/dev/null 2>&1 
    rm -rf /etc/systemd/system/xray.service.d
    cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF
  cat >/root/.profile <<END
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
mesg n || true
menu
END
chmod 644 /root/.profile
  cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/bin/xp
END

}
function configure() {
    cd
    rm -rf *
    rm /var/www/html/*.html
    rm /etc/nginx/sites-enabled/default
    rm /etc/nginx/sites-available/default
    wget ${GITHUB_CMD}oncom.zip >> /dev/null 2>&1
    unzip oncom.zip >> /dev/null 2>&1
    rm -f oncom.zip
    mv nginx.conf /etc/nginx/
    mv xray.conf /etc/nginx/conf.d/
    chmod +x *
    mv * /usr/bin/
}
update_ur_vps
make_folder_xray
acme
install_xray
configure
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
clear
echo "Autoscript berhasil di install"
