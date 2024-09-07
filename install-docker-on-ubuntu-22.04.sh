#!/bin/bash

echo "=== Install Docker Community Edition on Ubuntu 22.04 ==="
echo

echo "=== Preparation Before Installation ==="
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list to include Docker’s packages
sudo apt update

# Verify Docker CE is available in the repository
sudo apt-cache policy docker-ce

echo "=== Installing Docker Community Edition ==="
sudo apt install -y docker-ce

echo
echo "=== Docker Installation Completed ==="
echo

# Check Docker status
echo "=== Checking Docker status ==="
sudo systemctl status docker
