#!/bin/bash
sudo tee /etc/cron.d/odoo > /dev/null <<'EOF'
# Cron jobs for odoo
MAILTO=""
# Run an odoo task every 5 minutes
*/5 * * * * odoo /usr/bin/odoo --task-update
# Create a backup every day at 2 AM
0 2 * * * odoo /usr/bin/odoo --create-backup
EOF