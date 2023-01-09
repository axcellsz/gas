#!/bin/bash
# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
gray="\e[1;30m"
Blue="\033[36m"
GREEN='\033[0;32m'
grenbo="\e[92;1m"
yellow='\033[0;33m'
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
WKT=$(curl -s ipinfo.io/timezone)
IPVPS=$(curl -s ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
cname=$(awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo)
cores=$(awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo)
freq=$(awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo)
tram=$(free -m | awk 'NR==2 {print $2}')
swap=$(free -m | awk 'NR==4 {print $2}')
up=$(uptime | awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
nginx=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
ws=$( systemctl status ws | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
clear
if [[ $nginx == "running" ]]; then
    status_server="${grenbo}Online ✔${NC}"
else
    status_server="${RED}Offline ✖${NC}"
fi
## OUTPUT
printf "
$NC
$NC\e[032;1mOperating System :\e[0m \e[1m$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')\e[0m
$NC\e[032;1mTotal Amount Of RAM:\e[0m \e[1m$tram MB\e[0m
$NC\e[032;1mIsp & City Name:\e[0m \e[1m$ISP & $CITY\e[0m
$NC\e[032;1mIp VPS:\e[0m \e[1m$IPVPS\e[0m
$NC\e[032;1mDomain:\e[0m \e[1m$(cat /etc/xray/domain)\e[0m
$NC\e[032;1mSever Uptime:\e[0m \e[1m$( uptime -p  | cut -d " " -f 2-10000 )\e[0m
${RED}Ax-vpn${NC}(C)${Blue}t.me/davemachine89$NC
"
echo -e "\e[1m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e " Server Xray Status:" $status_server
echo -e "\e[1m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e " [${grenbo}v${NC}] ${RED}• ${NC}BUAT VMESS SET AKRAB$NC$gray$NC"
echo -e " [${grenbo}b${NC}] ${RED}• ${NC}BUAT VMESS SET FLEX$NC$gray$NC"
echo -e " [${grenbo}n${NC}] ${RED}• ${NC}BUAT VMESS SET DEFAULT$NC$gray$NC"
echo -e " [${grenbo}1${NC}] ${RED}• ${NC}HAPUS VMESS$NC$gray$NC"
echo -e " [${grenbo}2${NC}] ${RED}• ${NC}PERBARUI VMESS$NC$gray$NC"
echo -e " [${grenbo}3${NC}] ${RED}• ${NC}CEK VMESS$NC$gray$NC"
echo -e "\e[1m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e " [${grenbo}4${NC}]${RED}• ${NC}BUAT TROJAN$NC$gray$NC"
echo -e " [${grenbo}5${NC}]${RED}• ${NC}HAPUS TROJAN$NC$gray$NC"
echo -e " [${grenbo}6${NC}]${RED}• ${NC}PERBARUI TROJAN$NC$gray$NC"
echo -e " [${grenbo}7${NC}]${RED}• ${NC}CEK TROJAN$NC$gray$NC"
echo -e "\e[1m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e " [${grenbo}8${NC}]${RED}• ${NC}RESTART XRAY$NC$gray$NC"
echo -e " [${grenbo}z${NC}]${RED}• ${NC}SETTING$NC$gray$NC"
echo -e " [${grenbo}x${NC}]${RED}• ${NC}REBOOT VPS$NC$gray$NC"
echo -e " [${grenbo}c${NC}]${RED}• ${NC}EXIT$NC$gray$NC"
echo -e "\e[1m━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
read -p "Select From Options : " menu
case $menu in
    v)
        axb
    ;;
    b)
        flx
    ;;
    n)
        add-ws
    ;;
    1)
        del-ws
    ;;
    2)
        renew-ws
    ;;
    3)
        cek-ws
    ;;
    4)
        add-tr
    ;;
    5)
        del-tr
    ;;
    6)
        renew-tr
    ;;
    7)
        cek-tr
    ;;
    8)
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
echo -e " ${grenbo}SELESAI.. "
sleep 2
clear
menu
    ;;
    z)
        set-menu
    ;;
    x)
        reboot
    ;;
    c)
        exit
    ;;
    *)
        menu
    ;;
esac
