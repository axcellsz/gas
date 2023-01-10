#!/bin/bash
# WARNA
MR='\033[0;31m'
HT='\e[1;30m'
HJ='\e[92;1m'
clear
echo -e "${HT}====================================================================="
echo -e "${HT}IP   : "
echo -e "${HT}HOST : "
echo -e "${HT}OS   : "
echo -e "${HT}====================================================================="
read -p "Select From Options [ 1 - 8] : " menu
case $menu in
    1)
        beel
    ;;
    2)
        del-ws
    ;;
    3)
        renew-ws
    ;;
    4)
        cek-ws
    ;;
    5)
        add-tr
    ;;
    6)
        del-tr
    ;;
    7)
        renew-tr
    ;;
    8)
        cek-tr
    ;;
    9)
        exit
    ;;
    *)
        menu
    ;;
esac
