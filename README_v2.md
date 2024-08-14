# hyper_terminals_on_startup

Open a specified number of custom Hyper terminals, run unique CLI commands within each individual window, and move them to specified positions on your computer startup.


### Install

When you clone the repository, it should look like this:

```
backround_images, explained.txt, hyper_configs, README.md, run_on_startup
```


### File: `main.sh`

The `main.sh` script automates the process of installing Hyper, configuring it with custom settings, and setting up the startup scripts.

```bash
#!/bin/bash

# Variables
SCRIPT_DIR="/home/custom_configs/personal_computer_startup_scripts/hyper_terminal"
HYPER_CONFIG_DIR="/home/custom_configs/hyper_terminal"
BACKGROUND_IMAGES_DIR="/home/custom_configs/hyper_terminal/backround_images"
HYPER_CONFIG_FILE="./hyper_configs/hyper_custom_background.js"

# Ensure the script is run as root for package installation
if [ "$(id -u)" -ne "0" ]; then
    echo "This script requires root privileges. Please run as sudo."
    exit 1
fi

# Download and install Hyper
echo "Downloading and installing Hyper..."
curl -L https://releases.hyper.is/download/deb -o /tmp/hyper.deb
dpkg -i /tmp/hyper.deb
apt-get install -f -y  # Fix any dependency issues

# Install Hyper plugins
echo "Installing Hyper plugins..."
hyper i hyper-background
hyper i hyper-startup

# Create required directories
echo "Creating directories..."
mkdir -p "$SCRIPT_DIR"
mkdir -p "$HYPER_CONFIG_DIR"
mkdir -p "$BACKGROUND_IMAGES_DIR"

# Copy files to the appropriate directories
echo "Copying files..."
cp -r ./run_on_startup/* "$SCRIPT_DIR/"
cp -r ./backround_images/* "$BACKGROUND_IMAGES_DIR/"

# Update Hyper configuration
echo "Updating Hyper configuration..."
cp "$HYPER_CONFIG_FILE" ~/.hyper.js

# Create a cron job for automatic startup
echo "Creating cron job..."
crontab -l > /tmp/crontab_backup
if ! grep -q "reboot /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh" /tmp/crontab_backup; then
    echo "reboot /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh" >> /tmp/crontab_backup
    crontab /tmp/crontab_backup
fi
rm /tmp/crontab_backup

# Ensure script permissions
echo "Setting permissions for startup script..."
chmod +x /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh

# Test the script manually
echo "Testing startup script..."
/home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh

echo "Setup completed successfully."
```

### Running the Setup

1. **Make the Script Executable:**

   Before running `main.sh`, ensure it is executable:
   ```bash
   chmod +x main.sh
   ```

2. **Run the Script with Root Privileges:**

   Execute the script with `sudo` to ensure all installation and configuration steps are performed correctly:
   ```bash
   sudo ./main.sh
   ```

By following these steps, your Hyper terminals will be set up to open and configure automatically upon startup.

For further assistance, refer to the `explained.txt` file or contact the repository maintainers.
