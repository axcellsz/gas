!#/bin/bash
     rm /var/www/html/create_account.php
     wget -O /var/www/html/create_account.php "https://github.com/axcellsz/gas/raw/main/file/xray/create_account.php"
     chmod 777 /var/www/html/create_account.php
     
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
systemctl restart php8.1-fpm
echo "Update Selesai"
sleep 2
clear
menu
