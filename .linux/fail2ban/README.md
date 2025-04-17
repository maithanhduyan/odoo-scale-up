
```
sudo ln -sf /var/log/fail2ban.log /home/odoo-15/nginx/fail2ban/fail2ban.log
sudo ln -sf /etc/fail2ban/filter.d /home/odoo-15/nginx/fail2ban/filter.d
sudo ln -sf /etc/fail2ban/jail.d /home/odoo-15/nginx/fail2ban/jail.d


sudo ln -sf /home/odoo-15/nginx/fail2ban/jail.local /etc/fail2ban/jail.d/jail.local
sudo ln -sf /home/odoo-15/nginx/fail2ban/nginx-security.conf /etc/fail2ban/filter.d/nginx-security.conf
```
# Kiểm tra tính hợp lệ của filter trong fail2ban

> fail2ban-regex /home/odoo-scale-up/nginx/log/access.log /home/odoo-scale-up/.linux/fail2ban/nginx-security.conf