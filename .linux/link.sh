#!/bin/bash

# 
THIS_DIR=$(dirname "$(realpath "$0")")
if [ ! -f "$THIS_DIR/fail2ban" ]; then
  echo "Directory chứa file link.sh: $THIS_DIR"
  mkdir "$THIS_DIR/fail2ban"
fi
# 
MAIN_DIR="/home/odoo-scale-up"
# Đường dẫn file cấu hình fail2ban 
FAIL2BAN_CONFIG_DIR="/etc/fail2ban/jail.d"
FAIL2BAN_FILTER_DIR="/etc/fail2ban/filter.d"
# Đường dẫn file cấu hình logrotate
LOGROTATE_CONFIG_FILE="/etc/cron.daily/logrotate"

# Đường dẫn file cấu hình fail2ban tùy chỉnh
FAIL2BAN_DIR="$MAIN_DIR/.linux/fail2ban"
FAIL2BAN_LOG="/var/log/fail2ban.log"
SHORTCUT_FAIL2BAN_CONFIG_DIR="$FAIL2BAN_DIR/jail.d"
SHORTCUT_FAIL2BAN_FILTER_DIR="$FAIL2BAN_DIR/filter.d"
SHORTCUT_FAIL2BAN_LOG="$FAIL2BAN_DIR/fail2ban.log"

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

# ==============================================================================
if [ ! -f $SHORTCUT_FAIL2BAN_LOG ]; then 
  # Tạo symlink để dễ xem log
  sudo ln -s "$FAIL2BAN_LOG" "$SHORTCUT_FAIL2BAN_LOG"
fi
# ==============================================================================
# - **/etc/cron.d/**: Thư mục chứa các tập tin cấu hình bổ sung.
# sudo ln -sf /etc/cron.d /home/odoo-scale-up/.linux/cron/cron.d

# Các thư mục chứa script thực thi theo từng khoảng thời gian định sẵn.
# sudo ln -sf /etc/cron.hourly /home/odoo-scale-up/.linux/cron/cron.hourly
# sudo ln -sf /etc/cron.daily /home/odoo-scale-up/.linux/cron/cron.daily
# sudo ln -sf /etc/cron.weekly /home/odoo-scale-up/.linux/cron/cron.weekly
# sudo ln -sf /etc/cron.monthly /home/odoo-scale-up/.linux/cron/cron.monthly

# Thư mục chứa các tệp crontab của từng người dùng.
# sudo ln -sf /var/spool/cron /home/odoo-scale-up/.linux/cron/cron

# sudo ln -sf /var/spool/cron /home/odoo-scale-up/.linux/cron/cron