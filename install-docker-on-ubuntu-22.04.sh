#!/bin/bash

echo "=== Install Docker Community Edition on Ubuntu 22.04 ==="

echo "=== Preparation Before Installation ==="
echo

sudo apt update

sudo apt install apt-transport-https ca-certificates curl software-properties-common

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt-cache policy docker-ce

echo "=== Installing Docker Community Edition on Ubuntu 22.04 ==="
echo

sudo apt install docker-ce

echo
echo "=== Finish Installing ==="
echo

echo "=== Checking status docker ==="
sudo systemctl status docker




