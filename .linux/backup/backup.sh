#!/usr/bin/env bash
#
# backup.sh — Script backup Odoo database via HTTP API
#
# Yêu cầu:
#   - curl
#   - awk, grep, sed (có sẵn trên hầu hết Linux)
#   - File cấu hình backup.conf nằm cùng thư mục với script, định dạng INI:
#       [odoo]
#       url = https://yourodoodomain
#       db = your_db_name
#       user = your_odoo_user
#       password = your_odoo_password
#
#       [backup]
#       master_password = your_master_pwd
#       format = zip
#
# Cách dùng:
#   chmod +x backup.sh
#   ./backup.sh
#
# Lên lịch (ví dụ crontab):
#   # mỗi Chủ nhật 00:00
#   0 0 * * 0 /full/path/to/backup.sh >> /var/log/odoobackup.log 2>&1

set -euo pipefail

# --- Cấu hình ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/backup.conf"

if [[ ! -r "$CONFIG_FILE" ]]; then
  echo "ERROR: Không tìm thấy hoặc không thể đọc file cấu hình: $CONFIG_FILE" >&2
  exit 1
fi

# Hàm lấy giá trị từ file INI
# $1 = section, $2 = key
function cfg_get() {
  local section="$1" key="$2"
  awk -F'=' -v sec="[$section]" -v key="$key" '
    $0 == sec { in_sec=1; next }
    /^\[/ && in_sec { in_sec=0 }
    in_sec && $1 ~ key {
      gsub(/^[[:space:]]+|[[:space:]]+$/,"",$2)
      print $2
      exit
    }
  ' "$CONFIG_FILE"
}

# Đọc cấu hình
ODOO_URL="$(cfg_get odoo url)"
ODOO_DB="$(cfg_get odoo db)"
ODOO_USER="$(cfg_get odoo user)"
ODOO_PASSWORD="$(cfg_get odoo password)"

BACKUP_MASTER_PASSWORD="$(cfg_get backup master_password)"
BACKUP_FORMAT="$(cfg_get backup format)"

# Thư mục chứa backup
BACKUP_DIR="$SCRIPT_DIR/odoobackup"
mkdir -p "$BACKUP_DIR"

# --- Thực hiện backup ---
TIMESTAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
OUT_FILE="$BACKUP_DIR/${ODOO_DB}_${TIMESTAMP}.zip"

echo "[$(date +'%Y-%m-%d %H:%M:%S')] Bắt đầu backup: $ODOO_DB → $OUT_FILE"

# Gửi request backup
HTTP_STATUS=$(curl --silent --show-error --fail \
  --write-out '%{http_code}' \
  --user "$ODOO_USER:$ODOO_PASSWORD" \
  --request POST "$ODOO_URL/web/database/backup" \
  --form "master_pwd=$BACKUP_MASTER_PASSWORD" \
  --form "name=$ODOO_DB" \
  --form "backup_format=$BACKUP_FORMAT" \
  --output "$OUT_FILE.tmp" \
) || {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: Không thể gửi request backup (curl error)" >&2
  rm -f "$OUT_FILE.tmp"
  exit 1
}

if [[ "$HTTP_STATUS" -eq 200 ]]; then
  mv "$OUT_FILE.tmp" "$OUT_FILE"
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] Backup thành công."
  exit 0
else
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: Server trả về HTTP $HTTP_STATUS" >&2
  rm -f "$OUT_FILE.tmp"
  exit 1
fi
