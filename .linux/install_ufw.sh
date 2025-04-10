#!/bin/bash

# Kiểm tra quyền root
if [ "$(id -u)" -ne 0 ]; then
    echo "Vui lòng chạy script với quyền root."
    exit 1
fi

# Kiểm tra xem ufw đã được cài đặt chưa
if ! command -v ufw >/dev/null 2>&1; then
    echo "UFW chưa được cài đặt. Đang cài đặt..."
    apt-get update && apt-get install -y ufw
fi

# Cho phép SSH (mặc định cổng 22)
ufw allow ssh

# Cho phép cổng 443 (HTTPS)
ufw allow 443

# Kích hoạt ufw
echo "y" | ufw enable

# Hiển thị trạng thái của ufw
ufw status verbose