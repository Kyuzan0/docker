#!/bin/bash

# Perbarui paket dan install WireGuard
sudo apt update
sudo apt install -y wireguard

# Buat direktori untuk konfigurasi WireGuard
sudo mkdir -p /etc/wireguard

# Generate kunci privat dan publik untuk server
wg genkey | sudo tee /etc/wireguard/privatekey | wg pubkey | sudo tee /etc/wireguard/publickey

# Ambil kunci privat dan publik
PRIVATE_KEY=$(sudo cat /etc/wireguard/privatekey)
PUBLIC_KEY=$(sudo cat /etc/wireguard/publickey)

# Buat konfigurasi WireGuard
sudo bash -c "cat > /etc/wireguard/wg0.conf <<EOL
[Interface]
PrivateKey = $PRIVATE_KEY
Address = 10.0.0.1/24
ListenPort = 32445

# Pastikan ip_forwarding diaktifkan
PostUp = sysctl -w net.ipv4.ip_forward=1
PostDown = sysctl -w net.ipv4.ip_forward=0

# Konfigurasi iptables untuk NAT
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

EOL"

# Aktifkan dan jalankan WireGuard
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0

echo "WireGuard telah diinstall dan dikonfigurasi dengan alamat IP 10.0.0.1"
