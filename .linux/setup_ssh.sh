#!/bin/bash
#
# SSH Security Setup Script
#
# This script configures the SSH server by:
# - Disabling root login over SSH.
# - Enabling public key authentication and disabling password logins.
# - Changing the default SSH port (from 22 to 2222).
# - Restricting access to a specified IP.
# - Setting connection timeout values.
# - Limiting the number of failed connection attempts.
#

# Require root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

SSH_CONFIG="/etc/ssh/sshd_config"
BACKUP_FILE="/etc/ssh/sshd_config.bak"

echo "Backing up SSH configuration to ${BACKUP_FILE}..."
cp "$SSH_CONFIG" "$BACKUP_FILE"

# 1. Disable root login
sed -i 's/^#*PermitRootLogin .*/PermitRootLogin no/' "$SSH_CONFIG"

# 2. Use Public Key Authentication only
sed -i 's/^#*PasswordAuthentication .*/PasswordAuthentication no/' "$SSH_CONFIG"
sed -i 's/^#*PubkeyAuthentication .*/PubkeyAuthentication yes/' "$SSH_CONFIG"

# 3. Change the SSH port (example: change to 2222)
sed -i 's/^#*Port .*/Port 2222/' "$SSH_CONFIG"

# 4. Limit allowed IP addresses
# NOTE: Update "allowed_ip" and "your_username" with your actual IP and username.
ALLOWED_IP="192.168.1.100"
USER_NAME="your_username"
# Remove any previous Match block for Address if exists
sed -i '/^Match Address/d' "$SSH_CONFIG"
sed -i '/^    AllowUsers/d' "$SSH_CONFIG"
cat <<EOF >> "$SSH_CONFIG"

Match Address ${ALLOWED_IP}
        AllowUsers ${USER_NAME}
EOF

# 5. Set client timeout settings
sed -i 's/^#*ClientAliveInterval .*/ClientAliveInterval 300/' "$SSH_CONFIG"
sed -i 's/^#*ClientAliveCountMax .*/ClientAliveCountMax 2/' "$SSH_CONFIG"

# 6. Limit number of failed authentication attempts (example: 3)
sed -i 's/^#*MaxAuthTries .*/MaxAuthTries 3/' "$SSH_CONFIG"

# Restart SSH service to apply changes
if command -v systemctl >/dev/null; then
    systemctl restart sshd
else
    service ssh restart
fi

echo "SSH configuration updated successfully."