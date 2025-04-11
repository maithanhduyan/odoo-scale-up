#!/bin/bash
# Dùng cron job chạy backup hàng ngày
CURRENT_FILE_PATH="$(dirname "$(readlink -f "$0")")"


if [ ! -d "$CURRENT_FILE_PATH/.venv" ]; then
    if [ ! python3 -m venv --help &> /dev/null ]; then
        echo "python3-venv not found. Installing python3.12-venv..."
        # sudo apt update && sudo apt install -y python3.12-venv
    fi
    # Tạo môi trường ảo python3 với tên thư mục .env
    echo "Virtual environment not found. Creating .venv... in $CURRENT_FILE_PATH/.venv"
    cd "$CURRENT_FILE_PATH"
    python3 -m venv $CURRENT_FILE_PATH/.venv
    
    # Cài đặt các module
    # echo "Installing dependencies using pip from the virtual environment..."
    "$CURRENT_FILE_PATH/.venv/bin/pip3" install requests
    
    # Chạy app.py
    $CURRENT_FILE_PATH/.venv/bin/python3 $CURRENT_FILE_PATH/app.py
    echo "Backup hoàn thành."

else
# Chạy python3 app.py
$CURRENT_FILE_PATH/.venv/bin/python3 $CURRENT_FILE_PATH/app.py
echo "Backup hoàn thành."
fi


