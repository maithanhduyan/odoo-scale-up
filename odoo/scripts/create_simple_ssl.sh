#!/bin/bash

# Determine the directory of this script
THIS_DIR="$(dirname "$(realpath "$0")")"
PARENT_DIR=$(dirname "$THIS_DIR")
TARGET_DIR=""

# Traverse up the directory tree to find the parent folder named "nginx"
CURRENT_DIR="$THIS_DIR"
while [ "$CURRENT_DIR" != "/" ]; do
    if [ "$(basename "$CURRENT_DIR")" = "nginx" ]; then
        TARGET_DIR="$CURRENT_DIR"
        break
    fi
    CURRENT_DIR="$(dirname "$CURRENT_DIR")"
done

if [ -z "$TARGET_DIR" ]; then
    echo "Parent directory 'nginx' not found."
    exit 1
fi

# Create the ssl directory inside the found nginx folder
mkdir -p "$TARGET_DIR/ssl"
echo "Directory 'ssl' created in $TARGET_DIR"