# hyper_terminals_on_startup
Open specified amount of custom hyper terminals automatically, run custom unique cli cmd within each induvidual window and move them to specified pixels on computer start-up. Following this guide you will be able to set-up a personal terminal environment to arrive to when starting you're computer. 

## Features:

-   Create a Cron Job for Automatic Startup terminals on boot ✅
-   Custom amount of terminals opened ✅
-   Custom commands exuted within termianls ✅
-   custom placement terminals on screen ✅
-   Update Hyper Configuration ✅
-   Create Required Directories ✅


![Example terminal layout](./git_hub_images/example_layout_3.png)
![Example terminal layout](./git_hub_images/example_layout_1.png)
![Example terminal layout](./git_hub_images/example_layout_2.png)

## Table of Contents

1. [Features](#features)

2. [Installation](#installation)
   - [Cloning Git Repository](#cloning-git-repository)
   - [Installing requirements](#installing-requirements)
   - [Getting API Key from BotFather](#getting-api-key-from-botfather)
    - [Works out of the box 📦](#works-out-of-the-box-)
        - [Configuration](#configuration)

5. [Understanding Code Layout](#understanding-code-layout)
   - [Directory Layout](#directory-layout)
   - [Summary](#summary)

<br>
<br>
<br>


## Installation
### Cloning Git Repository
To clone Git repository using the command line, follow these simple steps:

1. Navigate to the dirctory on you're computer you wish to start coding.
2. Clone this GitHub repo:
```
git clone git@github.com:YnotY2/<public_repo_link>.git
```

<br>

### Installing requirements
To install requirements using the command line, follow these simple steps:

1. Navigate to the dir containing the 'requirements.txt' file.
2. Install the requirements:
```
pip install -r requirements.txt
```

<br>
<br>

### Executing 'main.sh'

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

3.  **Overwrite 'hyper.js configuration file'**
   Execute the script with `sudo` to ensure all installation and configuration steps are performed correctly:
  
   ```bash
   sudo su
   ```
  
   ```bash
   cat ./hyper_configs/hyper_custom_background.js > ~/.hyper.js
   ```


By following these steps, your Hyper terminals will be set up to open and configure automatically upon startup.

## Verifying Setup

- **Test the Script Manually:**

  You can test the script manually to ensure it works correctly:
  ```bash
  /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh
  ```

<br>
<br>
<br>


## Works out of the box 📦

## Configuration

- All these files are within: *"/home/custom_configs/personal_computer_startup_scripts/hyper_terminal"*
```
/home/custom_configs/personal_computer_startup_scripts/hyper_terminal/
```
**:**
```
execute_specified_cmds_within_open_hyper_terminals  move_and_resize_all_open_hyper_terminals  open_specified_amount_hyper_terminal_windows  startup_terminals.sh
```

### 1. Modify *'open_specified_amount_hyper_terminal_windows'* bash file: 
Specify the amount of terminal window's you want to open when the you're computer starts up. 

####  `open_specified_amount_hyper_terminal_windows`:

```python
#!/bin/bash

# Define the command to execute
command_to_execute="hyper"

# Number of times to execute the command
num_executions=5

# Loop to execute the command multiple times
for ((i=1; i<=$num_executions; i++)); do
    # Execute the command
    $command_to_execute &
    
    # Wait for 0.5 seconds before the next execution
    sleep 0.5
done
```
Modify the 'num_executions' variable to whatever value you wish.

-**Note:** The amount of terminals opened connot be less than the amount 
of commands executed within the terminal windows.

<br>
<br>

### 2. Modify *"move_and_resize_all_open_hyper_terminals"* bash file
####  `move_and_resize_all_open_hyper_terminals`:

```python
#!/bin/bash

# Get the window IDs of the terminal windows
window_ids=$(xdotool search --onlyvisible --class "Hyper")

# Counter for terminal windows
terminal_counter=0

# Loop through each window ID and move/resize as needed
for id in $window_ids; do
    # Increment terminal counter
    ((terminal_counter++))

    # Perform actions based on terminal counter
    case $terminal_counter in
        # Terminal 1: Move and resize top left landschape
        1)
            xdotool windowmove $id 10 43
            xdotool windowsize $id 943 370
            ;;
        # Terminal 2: Move and resize, bottem-middle left portrait
        2)
            xdotool windowmove $id 490 423
            xdotool windowsize $id 464 646
            ;;
        # Terminal 3: Move and resize, bottem right square
        3)
            xdotool windowmove $id 970 290
            xdotool windowsize $id 930 784
            ;;
        # Terminal 4: Move and resize, top right landschape
        4)
            xdotool windowmove $id 971 39
            xdotool windowsize $id 934 240
            ;;
        # Terminal 5: Move and resize, bottem left portrait
        5)
            xdotool windowmove $id 10 423
            xdotool windowsize $id 464 646
            ;;
        # Add more cases for additional terminals as needed
    esac
done

```
The int values within the script correspond to the pixels on you're screen. Play around with it to match you're personal needs. I recommend starting with both x and y values at 0.

<br>
<br>

### 3. Modify *"execute_specified_cmds_within_open_hyper_terminals"* bash file

```python
#!/bin/bash

# Function to execute a command in a terminal window
execute_command() {
    local id=$1
    local command=$2

    # Activate the terminal window
    xdotool windowactivate --sync $id

    # Clear the terminal window
    xdotool key --clearmodifiers "ctrl+l"

    # Type the command into the terminal window
    xdotool type --clearmodifiers "$command"

    # Press Enter to execute the command
    xdotool key --clearmodifiers "Return"

    # Wait for the command to execute
    sleep 0.2
}

# Get the window IDs of the terminal windows
window_ids=$(xdotool search --onlyvisible --class "Hyper")

# Counter for terminal windows
terminal_counter=0

# Commands to execute in each terminal window
commands=(
    "lsblk -f"
    "cd ..; ls"
    "cd /home/custom_configs/nftables; sudo nft list ruleset"
    "sudo apt-get update && sudo apt-get upgrade"
    "cat /home/ynoty2/Desktop/.project_switch/TODO"
)

# Loop through each window ID and execute the corresponding command
for id in $window_ids; do
    # Increment terminal counter
    ((terminal_counter++))

    # Check if the terminal ID is valid
    if [ -n "$id" ]; then
        # Execute the command in the current terminal window
        execute_command $id "${commands[$terminal_counter - 1]}"
    else
        echo "Error: Terminal window ID not found."
    fi
done

```
- Here within the file  you can specify what ever command you would wish to be executed within the open terminal commands:
```
commands=(
    "lsblk -f"
    "cd ..; ls"
    "cd /home/custom_configs/nftables; sudo nft list ruleset"
    "sudo apt-get update && sudo apt-get upgrade"
    "echo 'hello world'"
)
```
I recommend having the commands on the terminal at output a number in chronological order, so you know which commands to run in wanted  terminals:
```
commands=(
    "echo '1"
    "echo '2"
    "echo '3"
    "echo '4"
    "echo '5"
)
```

<br>
<br>

### 4. Modify *"startup_terminals.sh"* bash file
This file is responsible for executing above 3 files.

```python
#!/bin/bash

# Change directory to the location of your batch scripts
cd /home/custom_configs/personal_computer_startup_scripts/hyper_terminal

# Execute the first batch script
./open_specified_amount_hyper_terminal_windows
# Sleep for 2sec so all terminals are opened
sleep 2

# Execute the second batch script
./move_and_resize_all_open_hyper_terminals
# Sleep for 1 second after moving all terminals 
sleep 2

# Execute the third batch script
./execute_specified_cmds_within_open_hyper_terminals

```
You can personally modify the time it waits between taking actions. 

<br>
<br>
<br>
<br>


### File: `main.sh`

The `main.sh` script automates the process of installing Hyper, configuring it with custom settings, and setting up the startup scripts.

```bash
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

```



## Manually Setting Up

- **Download and Install Hyper:**

     ```bash
     curl -L https://releases.hyper.is/download/deb -o hyper.deb
     sudo dpkg -i hyper.deb
     sudo apt-get install -f  # Fix any dependency issues
     ```

- **Install Plugins:**

Open a terminal and run the following commands to install the hyper-background and hyper-startup plugins:
	bash```
	hyper i hyper-background
	hyper i hyper-startup
	```

Follow these steps to correctly configure your system:

1. **Create Required Directories:**

   - Create the directory for personal startup scripts:
     ```bash
     mkdir -p /home/custom_configs/personal_computer_startup_scripts/hyper_terminal
     ```

   - Create the directory for Hyper terminal configurations:
     ```bash
     mkdir -p /home/custom_configs/hyper_terminal
     ```

   - Create the directory for background images:
     ```bash
     mkdir -p /home/custom_configs/hyper_terminal/backround_images
     ```

2. **Copy Files:**

   - Copy all files from the `./run_on_startup/` directory to `/home/custom_configs/personal_computer_startup_scripts/hyper_terminal/`:
     ```bash
     cp -r ./run_on_startup/* /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/
     ```

   - Copy all files from `./backround_images/` to `/home/custom_configs/hyper_terminal/backround_images/`:
     ```bash
     cp -r ./backround_images/* /home/custom_configs/hyper_terminal/backround_images/
     ```

3. **Update Hyper Configuration:**

   - Overwrite the file content of `~/.hyper.js` with `./hyper_configs/hyper_custom_background.js`:
     ```bash
     cp ./hyper_configs/hyper_custom_background.js ~/.hyper.js
     ```

4. **Create a Cron Job for Automatic Startup:**

   - Open your crontab configuration:
     ```bash
     crontab -e
     ```

   - Add the following line to execute the `startup_terminals.sh` script at startup:
     ```bash
     reboot /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh
     ```

   - Save and exit the editor.

## Verifying Setup

- **Ensure Script Permissions:**

  Make sure the `startup_terminals.sh` script is executable:
  ```bash
  chmod +x /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh
  ```

- **Test the Script Manually:**

  You can test the script manually to ensure it works correctly:
  ```bash
  /home/custom_configs/personal_computer_startup_scripts/hyper_terminal/startup_terminals.sh
  ```

By following these steps, your `startup_terminals.sh` script will run at startup, automatically opening and configuring your Hyper terminals as specified.

For further assistance, refer to the `explained.txt` file or contact the repository maintainers.
