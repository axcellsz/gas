#!/bin/bash
clear
# menu update vps
echo-e "update vps"
sleep 2
    apt update && apt upgrade -y
    apt install socat cron zip unzip -y
    apt install curl
# domain vps
echo -e "atur domain"
sleep 2
read -rp "Masukan Domain :" domain
# membuat folder ray
echo -e "buat folder xray"
sleep 1
    mkdir -p /etc/xray
    mkdir -p /var/log/xray
    chmod +x /var/log/xray
    echo "${domain}" >/etc/xray/domain
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
# install sertifikat
echo -e "install sertifikat"
sleep 2
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
# install xray
echo -e "install nginx"
sleep 2
    apt install nginx -y
    curl -s ipinfo.io/city >>/etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 1.6.5
    wget -O /etc/xray/config.json "https://github.com/axcellsz/gas/raw/main/file/config.json"
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
# konfigurasi menu
echo -e "konfigurasi menu"
sleep 1
    cd
    rm -rf *
    rm /var/www/html/*.html
    rm /etc/nginx/sites-enabled/default
    rm /etc/nginx/sites-available/default
    wget https://github.com/axcellsz/gas/raw/main/axz.zip
    unzip axz.zip
    rm -f axz.zip
    mv nginx.conf /etc/nginx/
    mv xray.conf /etc/nginx/conf.d/
    chmod +x *
    mv * /usr/bin/
# restart
echo -e "restart xray"
sleep 2
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
clear
echo "Autoscript berhasil di install"
sleep 2
menu
