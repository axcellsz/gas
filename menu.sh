#!/usr/bin/env bash

XRAY_CONFIG="/usr/local/etc/xray/config.json"
DOMAIN_FILE="/etc/xray/domain"
WS_PATH="/vless"
PORT="443"

DOMAIN="$(cat $DOMAIN_FILE 2>/dev/null)"

pause() {
  read -rp "Tekan ENTER untuk lanjut..."
}

restart_all() {
  systemctl restart xray
  systemctl restart nginx
  echo "✔ Xray & Nginx direstart"
  pause
}

list_vless() {
  echo "==== LIST AKUN VLESS ===="
  jq -r '.inbounds[0].settings.clients[] | "UUID: \(.id)"' "$XRAY_CONFIG"
  pause
}

add_vless() {
  read -rp "Masukkan nama akun: " USER
  UUID="$(uuidgen)"

  jq ".inbounds[0].settings.clients += [{\"id\":\"$UUID\",\"email\":\"$USER\"}]" \
    "$XRAY_CONFIG" > /tmp/xray.tmp && mv /tmp/xray.tmp "$XRAY_CONFIG"

  systemctl restart xray

  echo
  echo "✔ AKUN BERHASIL DIBUAT"
  echo "User : $USER"
  echo "UUID : $UUID"
  echo
  echo "VLESS LINK:"
  echo "vless://${UUID}@${DOMAIN}:${PORT}?encryption=none&security=tls&type=ws&path=${WS_PATH}&host=${DOMAIN}#${USER}"
  echo
  pause
}

delete_vless() {
  list_vless
  read -rp "Masukkan UUID yang mau dihapus: " UUID

  jq "del(.inbounds[0].settings.clients[] | select(.id==\"$UUID\"))" \
    "$XRAY_CONFIG" > /tmp/xray.tmp && mv /tmp/xray.tmp "$XRAY_CONFIG"

  systemctl restart xray
  echo "✔ AKUN BERHASIL DIHAPUS"
  pause
}

while true; do
clear
cat <<EOF
===========================
        MENU XRAY
===========================
B. Buat akun VLESS
H. Hapus akun VLESS
L. List akun VLESS
R. Restart Xray + Nginx
Q. Keluar
===========================
Domain : $DOMAIN
===========================
EOF

read -rp "Masukan pilihan: " opt
case "$opt" in
  B|b) add_vless ;;
  H|h) delete_vless ;;
  L|l) list_vless ;;
  R|r) restart_all ;;
  Q|q) exit 0 ;;
  *) echo "Pilihan salah"; pause ;;
esac
done
