#!/bin/bash
# Step 1.3 Install MariaDB 10.5 on Amazon Linux 2023

echo "Updating packages..."
sudo dnf update -y

echo "Installing MariaDB 10.5 server and client..."
sudo dnf install mariadb105-server mariadb105 -y

echo "Starting and enabling MariaDB service..."
sudo systemctl start mariadb
sudo systemctl enable mariadb

echo "Securing MariaDB installation (follow prompts)..."
sudo mysql_secure_installation

echo "Verifying MariaDB service status..."
sudo systemctl status mariadb
