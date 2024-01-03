!#/bin/bash
    cd
     rm -rf *
     rm /var/www/html/*.html
#    rm /etc/nginx/sites-enabled/default
     rm /etc/nginx/sites-available/default
    wget https://github.com/axcellsz/gas/raw/main/file/axz.zip
    unzip axz.zip
    rm -f axz.zip
    mv nginx.conf /etc/nginx/
    mv default /etc/nginx/sites-available/
    mv xray.conf /etc/nginx/conf.d/
    mv ac.sh aktif create_account.php index.php user /var/www/html/
    chmod 777 /var/www/html/*
    chmod +x *
    mv * /usr/bin/
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
echo "Install Selesai"
sleep 2
clear
menu
