#!/bin/bash
clear
echo -e "1. VMESS AKRAB"
echo -e "2. VMESS FLEX"
echo -e "3. VMESS MANUAL BUG"
echo -e "3. VMESS DEFAULT"
read -p "     Select From Options :  " vvv
case $vvv in 
1)
axb
;;
2)
flx
;;
3)
man
;;
4)
add-ws
;;
*)
echo "Input The Correct Number !"
;;
esac
