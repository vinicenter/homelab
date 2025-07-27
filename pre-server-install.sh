#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Prompt for the new hostname
read -p "Enter the new hostname: " HOSTNAME

# Set the hostname
hostnamectl set-hostname "$HOSTNAME"

curl -fsSL https://tailscale.com/install.sh | sh

tailscale up

echo "Hostname successfully changed to $HOSTNAME"
echo "Tailscale installed and connected"
