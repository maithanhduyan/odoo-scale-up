#!/bin/bash
# Script to set the system timezone to UTC

# Must be run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

# Set timezone to UTC
timedatectl set-timezone UTC

# Verify the change
echo "Current time settings:"
timedatectl