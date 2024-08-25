#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Prompt for the new hostname
read -p "Enter the new hostname: " HOSTNAME

# Prompt for the username
read -p "Enter the username to add the public key to: " USERNAME

# Prompt for the public key
read -p "Enter the public key: " PUBLIC_KEY

# Set the hostname
hostnamectl set-hostname "$HOSTNAME"

# Add the public key to the authorized_keys for the specified user
USER_HOME=$(eval echo ~$USERNAME)
AUTHORIZED_KEYS_FILE="$USER_HOME/.ssh/authorized_keys"

# Create .ssh directory if it doesn't exist
if [ ! -d "$USER_HOME/.ssh" ]; then
    mkdir -p "$USER_HOME/.ssh"
    chown "$USERNAME":"$USERNAME" "$USER_HOME/.ssh"
    chmod 700 "$USER_HOME/.ssh"
fi

# Add the public key
echo "$PUBLIC_KEY" >> "$AUTHORIZED_KEYS_FILE"
chown "$USERNAME":"$USERNAME" "$AUTHORIZED_KEYS_FILE"
chmod 600 "$AUTHORIZED_KEYS_FILE"

curl -fsSL https://tailscale.com/install.sh | sh

tailscale up

echo "Hostname successfully changed to $HOSTNAME"
echo "Public key added to $AUTHORIZED_KEYS_FILE for user $USERNAME"
echo "Tailscale installed and connected"
