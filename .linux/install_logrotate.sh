#!/bin/bash

# Đường dẫn file cấu hình logrotate tùy chỉnh
THIS_DIR=$(dirname "$(realpath "$0")")
PARENT_DIR=$(dirname "$THIS_DIR")
CONFIG_DIR="$THIS_DIR/logrotate"
CONFIG_FILE="$CONFIG_DIR/docker"
SYMLINK_PATH="/etc/logrotate.d/docker"

# BƯỚC 1: Tạo thư mục chứa file cấu hình nếu chưa tồn tại
mkdir -p "$CONFIG_DIR"

# BƯỚC 2: Tạo nội dung file cấu hình logrotate
cat > "$CONFIG_FILE" <<EOF
$PARENT_DIR/odoo/log/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    copytruncate
}

$PARENT_DIR/nginx/log/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    copytruncate
}
EOF

echo "✅ Đã tạo file cấu hình logrotate tại: $CONFIG_FILE"

# BƯỚC 3: Tạo symlink vào /etc/logrotate.d/ để logrotate mặc định tự động chạy
if [ -L "$SYMLINK_PATH" ]; then
    echo "ℹ️ Symlink đã tồn tại. Cập nhật lại."
    sudo rm "$SYMLINK_PATH"
fi

sudo ln -s "$CONFIG_FILE" "$SYMLINK_PATH"
echo "✅ Đã tạo symlink tới logrotate: $SYMLINK_PATH → $CONFIG_FILE"

# BƯỚC 4: Kiểm tra cấu hình logrotate
echo "🧪 Kiểm tra cấu hình logrotate..."
sudo logrotate -d "$CONFIG_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Cấu hình hợp lệ. Logrotate sẽ tự động chạy mỗi ngày."
else
    echo "❌ Có lỗi trong cấu hình logrotate. Vui lòng kiểm tra lại: $CONFIG_FILE"
    exit 1
fi
