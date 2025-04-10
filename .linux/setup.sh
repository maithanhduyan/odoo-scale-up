#!/bin/bash
THIS_DIR=$(dirname "$(realpath "$0")")
echo "📁 $THIS_DIR"
PARENT_DIR=$(dirname "$THIS_DIR")
echo "📁 $PARENT_DIR"

NEW_USER="newuser"
if id "$NEW_USER" >/dev/null 2>&1; then
    echo "👤 User '$NEW_USER' already exists."
    mkdir -p postgresql/data odoo/addons odoo/conf odoo/web-data odoo/log nginx/conf nginx/ssl nginx/html nginx/log certbot/logs
    sudo chown -R $NEW_USER:$NEW_USER postgresql odoo nginx certbot
    sudo chmod -R 755 postgresql odoo nginx certbot
else
    adduser --disabled-password --gecos "" "$NEW_USER"
    usermod -aG sudo "$NEW_USER"
    echo "User '$NEW_USER' created and granted sudo privileges."
fi

chmod -R 777 "$PARENT_DIR"
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