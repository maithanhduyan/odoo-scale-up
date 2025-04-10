#!/bin/bash
THIS_DIR=$(dirname "$(realpath "$0")")
echo "📁 $THIS_DIR"
PARENT_DIR=$(dirname "$THIS_DIR")
echo "📁 $PARENT_DIR"

NEW_USER="odoo-scale-up"
USER_UID=1000
USER_GID=1000

# Kiểm tra nếu user đã tồn tại
if id "$NEW_USER" >/dev/null 2>&1; then
    echo "👤 User '$NEW_USER' already exists."
else
    # Tạo user với UID và GID cụ thể
    groupadd -g $USER_GID "$NEW_USER"
    useradd -m -u $USER_UID -g $USER_GID -s /bin/bash "$NEW_USER"
    echo "User '$NEW_USER' created with UID=$USER_UID and GID=$USER_GID."
fi
# Tạo các thư mục cần thiết
mkdir -p postgresql/data odoo/addons odoo/conf odoo/web-data odoo/log nginx/log

# Gán quyền sở hữu cho user 'odoo'
sudo chown -R $USER_UID:$USER_GID ./nginx/log
sudo chown -R $USER_UID:$USER_GID ./odoo
sudo chown -R $USER_UID:$USER_GID ./postgresql/data

# Gán quyền truy cập
sudo chmod -R 775 ./nginx/log
sudo chmod -R 775 ./odoo
sudo chmod -R 775 ./postgresql/data

echo "✅ Permissions and ownership have been set successfully."

# Font Courier là một font phổ biến, nhưng có thể không được cài đặt sẵn trong container Odoo. Bạn có thể thêm font này bằng cách sửa Dockerfile hoặc chạy lệnh trong container.
sudo apt update && sudo apt install gsfonts -y

# ==============================================================================
# if [ -f install_fail2ban.sh ]; then
#     bash install_fail2ban.sh
# else
#     echo "❌ File install_fail2ban.sh không tồn tại, Docker sẽ không được cài đặt."
# fi

# ==============================================================================
# if [ -f install_docker.sh ]; then
#     bash install_docker.sh
# else
#     echo "❌ File install_docker.sh không tồn tại, Docker sẽ không được cài đặt."
# fi

# ==============================================================================
#  Install Kubernetes k8s
# ==============================================================================