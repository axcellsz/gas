!#/bin/bash
rm -rf /var/www/html/*
    wget -O /var/www/html/aktif "https://github.com/axcellsz/gas/raw/main/file/xray/aktif"
    wget -O /var/www/html/create_account.php "https://github.com/axcellsz/gas/raw/main/file/xray/create_account.php"
    wget -O /var/www/html/index.php "https://github.com/axcellsz/gas/raw/main/file/xray/index.php"
    wget -O /var/www/html/user "https://github.com/axcellsz/gas/raw/main/file/xray/user"
    wget -O /var/www/html/web-default "https://github.com/axcellsz/gas/raw/main/file/xray/web-default"
    wget -O /var/www/html/web-flex "https://github.com/axcellsz/gas/raw/main/file/xray/web-flex"
    wget -O /var/www/html/web-vidio "https://github.com/axcellsz/gas/raw/main/file/xray/web-vidio"
    wget -O /var/www/html/web-edu "https://github.com/axcellsz/gas/raw/main/file/xray/web-edu"

rm -rf *
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
systemctl restart php8.1-fpm
echo "Update Selesai"
sleep 2
clear
menu
