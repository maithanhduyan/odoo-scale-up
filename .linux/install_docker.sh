#!/bin/bash

if command -v docker >/dev/null 2>&1; then
    # Gỡ bỏ các phiên bản Docker cũ (nếu có)
    sudo apt remove -y docker docker-engine docker.io containerd runc

    # Cài đặt các gói cần thiết để apt có thể sử dụng HTTPS:
    sudo apt install -y ca-certificates curl gnupg lsb-release

    # Thêm khóa GPG chính thức của Docker:
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Thiết lập kho chứa Docker:
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Cập nhật danh sách gói:
    sudo apt update

    # Cài đặt Docker Engine, containerd và docker-compose plugin:
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Kích hoạt và khởi động Docker:
    sudo systemctl enable docker
    sudo systemctl start docker

    echo "✅ Docker đã được cài đặt và chạy thành công trên Ubuntu."

    echo "Docker đã được cài đặt, phiên bản:"
    docker --version
else
    echo "Docker chưa được cài đặt."
fi

if command -v docker-compose >/dev/null 2>&1; then
    echo "✅ docker-compose đã được cài đặt. Phiên bản: $(docker-compose --version)"
else
    echo "Cài đặt docker-compose..."
    sudo apt install -y docker-compose
    echo "✅ docker-compose đã được cài đặt. Phiên bản:"
    docker-compose --version
fi