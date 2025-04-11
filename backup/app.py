import requests
import os
from datetime import datetime
import time

ODOO_URL = 'http://127.0.0.1:8069'
ODOO_DB = 'taya_db'
ODOO_USER = 'openpg'
ODOO_PASSWORD = 'openpgpwd@2024'
BACKUP_MASTER_PASSWORD = 'admin'
BACKUP_FORMAT = 'zip'
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
print("Current file directory:", SCRIPT_DIR)
BACKUP_DIR = os.path.join(SCRIPT_DIR, 'storage')
os.makedirs(BACKUP_DIR, exist_ok=True)

def backup():
    print(datetime.now(), "Running Odoo backup ...")
    date_time = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    data = {
        'master_pwd': BACKUP_MASTER_PASSWORD,
        'name': ODOO_DB,
        'backup_format': BACKUP_FORMAT,
    }
    response = requests.post(
        f"{ODOO_URL}/web/database/backup",
        auth=(ODOO_USER, ODOO_PASSWORD),
        data=data
    )
    if response.status_code == 200:
        with open(f"{BACKUP_DIR}/{ODOO_DB}_{date_time}.zip", "wb") as file:
            file.write(response.content)
        print(f"Backup request sent successfully at {date_time}.")
    else:
        print("Failed to send backup request.")

backup()
