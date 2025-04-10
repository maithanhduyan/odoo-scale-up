#!/bin/bash

# Update package list
sudo apt update

# Install fail2ban quietly (-y to answer yes automatically)
sudo apt install -y fail2ban

# Enable and start the fail2ban service
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

echo "✅ fail2ban đã được cài đặt và chạy thành công trên Ubuntu."
