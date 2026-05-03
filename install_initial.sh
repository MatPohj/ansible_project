#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "--- Starting Infrastructure Tooling Installation ---"

# 1. Update system and install Python/Ansible dependencies
echo "Installing Python3, Pip, and UpCloud Ansible collection..."
sudo apt update && sudo apt install -y python3-pip
pip3 install "upcloud-api>=2.5.0" --break-system-packages
ansible-galaxy collection install upcloud.cloud

# 2. Install GPG and software properties
echo "Installing gnupg and software-properties-common..."
sudo apt-get update && sudo apt-get install -y gnupg coreutil curl ssh ansible

# make ssh key
ssh-keygen

# 3. Add HashiCorp GPG key
echo "Adding HashiCorp GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# 4. Verify the fingerprint
echo "Verifying HashiCorp keyring fingerprint..."
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

# 5. Add HashiCorp repository
echo "Adding HashiCorp repository to sources..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# 6. Install Terraform
echo "Updating package lists and installing Terraform..."
sudo apt update
sudo apt-get install -y terraform

echo "--- Installation Complete! ---"
terraform -version
