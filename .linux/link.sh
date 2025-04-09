#!/bin/bash

# 
THIS_DIR=$(dirname "$(realpath "$0")")
echo "Directory chứa file link.sh: $SCRIPT_DIR"
if [ ! -f "$THIS_DIR/fail2ban" ]; then
    mkdir "$THIS_DIR/fail2ban"
fi
# 
MAIN_DIR="/home/odoo-scale-up"
# Đường dẫn file cấu hình fail2ban 
FAIL2BAN_CONFIG_DIR="/etc/fail2ban/jail.d"
FAIL2BAN_FILTER_DIR="/etc/fail2ban/filter.d"
# Đường dẫn file cấu hình logrotate
LOGROTATE_CONFIG_FILE=""
LOGROTATE_LOG_FILE=""

# Đường dẫn file cấu hình fail2ban tùy chỉnh
SHORTCUT_FAIL2BAN_CONFIG_DIR="$MAIN_DIR/.linux/fail2ban/jail.d"
SHORTCUT_FAIL2BAN_FILTER_DIR="$MAIN_DIR/.linux/fail2ban/filter.d"

# LOG SHORTCUT
if [ ! -f $SHORTCUT_FAIL2BAN_CONFIG_DIR ]; then
  sudo ln -sf "$FAIL2BAN_CONFIG_DIR" "$SHORTCUT_FAIL2BAN_CONFIG_DIR"
  echo "✅ Đã tạo shortcut cho $SHORTCUT_FAIL2BAN_CONFIG_DIR"
fi

# 
if [ ! -f $SHORTCUT_FAIL2BAN_FILTER_DIR ]; then
  sudo ln -sf "$FAIL2BAN_FILTER_DIR" "$SHORTCUT_FAIL2BAN_FILTER_DIR"
  echo "✅ Đã tạo shortcut cho $SHORTCUT_FAIL2BAN_FILTER_DIR"
fi

# ------------------------------------------------------------------------------