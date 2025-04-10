#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
echo "Directory chứa file checklist.sh: $SCRIPT_DIR"

if command -v git &> /dev/null; then
  echo "✅ Git đã được cài đặt trên hệ thống."
else
  echo "❌ Git chưa được cài đặt trên hệ thống."
fi
# ==============================================================================
if command -v python &> /dev/null; then
  echo "✅ Python đã được cài đặt trên hệ thống."
else
  echo "❌ Python chưa được cài đặt trên hệ thống."
fi

# ==============================================================================

if command -v fail2ban-client &> /dev/null; then
  echo "✅ Fail2Ban đã được cài đặt trên hệ thống."
else
  echo "❌ Fail2Ban chưa được cài đặt trên hệ thống."
fi

# ==============================================================================

if command -v webmin &> /dev/null; then
  echo "✅ Web-min đã được cài đặt trên hệ thống."
else
  echo "❌ Web-min chưa được cài đặt trên hệ thống."
fi