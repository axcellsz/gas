!#/bin/bash
#     rm /var/www/html/create_account.php
#     wget -O /var/www/html/create_account.php "https://github.com/axcellsz/gas/raw/main/file/xray/create_account.php"
#     chmod 777 /var/www/html/create_account.php

#     rm /usr/bin/menu
#     wget -O /usr/bin/menu "https://github.com/axcellsz/gas/raw/main/file/xray/menu"
#     chmod 777 /usr/bin/menu

      wget -O /var/www/html/web-default "https://github.com/axcellsz/gas/raw/main/file/xray/web-default"
      chmod 777 /var/www/html/web-default

      wget -O /var/www/html/web-flex "https://github.com/axcellsz/gas/raw/main/file/xray/web-flex"
      chmod 777 /var/www/html/web-flex

      wget -O /var/www/html/web-vidio "https://github.com/axcellsz/gas/raw/main/file/xray/web-vidio"
      chmod 777 /var/www/html/web-vidio

      wget -O /var/www/html/web-edu "https://github.com/axcellsz/gas/raw/main/file/xray/web-edu"
      chmod 777 /var/www/html/web-edu
    
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
systemctl restart php8.1-fpm
echo "Update Selesai"
sleep 2
clear
menu
