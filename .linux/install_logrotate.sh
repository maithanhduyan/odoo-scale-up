#!/bin/bash
if command -v logrotate >/dev/null 2>&1; then
    echo "Logrotate đã được cài đặt, phiên bản:"
    logrotate --version
else
    echo "Logrotate chưa được cài đặt. Đang tiến hành cài đặt..."
    if [ -f /etc/debian_version ]; then
        sudo apt-get update && sudo apt-get install -y logrotate
    elif [ -f /etc/redhat-release ]; then
        sudo yum install -y logrotate
    else
        echo "Hệ điều hành không được hỗ trợ tự động cài đặt. Vui lòng cài đặt logrotate thủ công."
        exit 1
    fi
fi

# Đường dẫn file cấu hình logrotate tùy chỉnh
THIS_DIR=$(dirname "$(realpath "$0")")
PARENT_DIR=$(dirname "$THIS_DIR")
CONFIG_DIR="$THIS_DIR/logrotate"
CONFIG_FILE="$CONFIG_DIR/docker"
SYMLINK_PATH="/etc/logrotate.d/docker"
LOGROTATE_CRON_CONFIG="/etc/cron.daily/logrotate"
SHORTCUT_LOGROTATE_CRON_CONFIG="$THIS_DIR/logrotate"

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

echo "🧪 Kiểm tra cấu hình logrotate..."
sudo logrotate -d "$CONFIG_FILE"

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

if [ ! -f $SHORTCUT_LOGROTATE_CRON_CONFIG ]; then
    sudo ln -sf "$LOGROTATE_CRON_CONFIG" "$SHORTCUT_LOGROTATE_CRON_CONFIG"
fi