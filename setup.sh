#!/bin/bash
# setup.sh - Configure a web server instance for the scale set
# This script runs as root on each new instance

set -euo pipefail

# Log everything to a file for debugging
# exec > /var/log/setup-script.log 2>&1
echo "Starting setup at $(date)"

# Update package lists and install dependencies
# apt-get update
# apt-get install -y nodejs npm

# Add Docker's official GPG key:
sudo apt update
sudo apt -y install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Setup completed at $(date)"
