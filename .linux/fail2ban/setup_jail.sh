#!/bin/bash

# Đường dẫn file cấu hình
THIS_DIR=$(dirname "$(realpath "$0")")
PARENT_DIR=$(dirname "$THIS_DIR")
FAIL2BAN_CONFIG_DIR="/etc/fail2ban/jail.d"
FAIL2BAN_FILTER_DIR="/etc/fail2ban/filter.d"
FAIL2BAN_CUSTOM_JAIL="$THIS_DIR/jail.local"
FAIL2BAN_CUSTOM_FILTER="$THIS_DIR/nginx-malicious-requests.conf"

FAIL2BAN_LOG="/var/log/fail2ban.log"
FAIL2BAN_LOG_SHORTCUT="$THIS_DIR/fail2ban.log"

# 
if [ ! -f $FAIL2BAN_CUSTOM_FILTER ]; then
  touch $FAIL2BAN_CUSTOM_FILTER
  echo "✅ Đã tạo file $FAIL2BAN_CUSTOM_FILTER"
fi
sudo ln -sf "$FAIL2BAN_CUSTOM_FILTER" "$FAIL2BAN_FILTER_DIR/nginx-malicious-requests.conf"

# 
if [ ! -f $FAIL2BAN_CUSTOM_JAIL ]; then
  touch $FAIL2BAN_CUSTOM_JAIL
  echo "✅ Đã tạo file $FAIL2BAN_CUSTOM_JAIL"
fi
sudo ln -sf "$FAIL2BAN_CUSTOM_JAIL" "$FAIL2BAN_CONFIG_DIR/jail.local"


# Restart fail2ban

sudo systemctl restart fail2ban
if systemctl is-active --quiet fail2ban; then
  echo "✅ Dịch vụ fail2ban đang hoạt động"
else
  echo "❌ Dịch vụ fail2ban không hoạt động"
fi

# Tạo symlink để dễ xem log
if [ ! -f "$FAIL2BAN_LOG_SHORTCUT" ]; then
  sudo ln -sf "$FAIL2BAN_LOG" "$FAIL2BAN_LOG_SHORTCUT"
  echo "✅ Đã tạo link $FAIL2BAN_LOG_SHORTCUT"
else
  echo "✅ Xem log fail2ban tại $FAIL2BAN_LOG_SHORTCUT"
fi