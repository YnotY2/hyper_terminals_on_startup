#!/bin/bash

# Variables
SCRIPT_DIR="/home/custom_configs/personal_computer_startup_scripts/hyper_terminal"
HYPER_CONFIG_DIR="/home/custom_configs/hyper_terminal"
BACKGROUND_IMAGES_DIR="/home/custom_configs/hyper_terminal/background_images"
HYPER_CUSTOM_CONFIG_FILE="./hyper_configs/hyper_custom_background.js"
HYPER_CONFIG_FILE = "~/.hyper.js"

# Ensure the script is run as root for package installation
if [ "$(id -u)" -ne "0" ]; then
    echo "This script requires root privileges for installing Hyper. Please run as sudo."
    exit 1
fi

# Download and install Hyper
echo "Downloading and installing Hyper..."
curl -L https://releases.hyper.is/download/deb -o /tmp/hyper.deb
dpkg -i /tmp/hyper.deb
apt-get install -f -y  # Fix any dependency issues

# Create required directories
echo "Creating directories..."
mkdir -p "$SCRIPT_DIR"
mkdir -p "$HYPER_CONFIG_DIR"
mkdir -p "$BACKGROUND_IMAGES_DIR"

# Copy files to the appropriate directories
echo "Copying files..."
cp -r ./run_on_startup/* "$SCRIPT_DIR/"
cp -r ./background_images/* "$BACKGROUND_IMAGES_DIR/"
cp -r "$HYPER_CUSTOM_CONFIG_FILE" "$HYPER_CONFIG_DIR/"

# Make the scripts executable
echo "Making scripts executable"
chmod +x "$SCRIPT_DIR="/*

# Update Hyper configuration
echo "Updating Hyper configuration..."
cp -r "$HYPER_CUSTOM_CONFIG_FILE" "$HYPER_CONFIG_FILE"

# Create a cron job for automatic startup
echo "Creating cron job..."
crontab -l > /tmp/crontab_backup
if ! grep -q "@reboot /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh" /tmp/crontab_backup; then
    echo "@reboot /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh" >> /tmp/crontab_backup
    crontab /tmp/crontab_backup
fi
rm /tmp/crontab_backup

# Ensure script permissions
echo "Setting permissions for startup script..."
chmod +x /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh

# Switch to regular user to install Hyper plugins
sudo -u $(logname) bash <<EOF
echo "Installing Hyper plugins..."
hyper i hyper-background
hyper i hyper-startup
EOF

# Test the script manually
echo "Testing startup script... :"
echo "/home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh"
echo ""
echo "Setup completed successfully."
