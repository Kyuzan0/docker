#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Install Docker Community Edition on Ubuntu 22.04 ===${NC}"
echo

echo -e "${YELLOW}=== Preparation Before Installation ===${NC}"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key if it doesn't already exist
if [ ! -f /usr/share/keyrings/docker-archive-keyring.gpg ]; then
    echo -e "${YELLOW}=== Adding Docker GPG key ===${NC}"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
else
    echo -e "${GREEN}Docker GPG key already exists, skipping download.${NC}"
fi

# Set up the Docker stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list to include Docker’s packages
sudo apt update

# Verify Docker CE is available in the repository
sudo apt-cache policy docker-ce
echo

echo -e "${YELLOW}=== Installing Docker Community Edition ===${NC}"
sudo apt install -y docker-ce

echo
echo -e "${GREEN}=== Docker Installation Completed ===${NC}"
echo

# Check Docker status
echo -e "${YELLOW}=== Checking Docker status ===${NC}"
sudo systemctl status docker
