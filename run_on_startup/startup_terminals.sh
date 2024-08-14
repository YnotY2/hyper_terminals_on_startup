#!/bin/bash
# This is a startup_script to open terminals and run cmds within them each time com starts
# I am assuming when I git clone the repo it looks like so:



# Make sure to also create a dir '/home/custom_configs/hyper_terminal/' :: This is where the actually different of single hyper.js terminal configs are stored
# Change directory to the location of your batch scripts
cd /home/custom_configs/personal_computer_startup_scripts/hyper_terminal

# This means all these files should reside within that dir
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

# Steps to setting up custom hyper-terminals: 
# 1, Create the dir path /home/custom_configs/personal_computer_startup_scripts/hyper_terminal
# 2, Create dir path /home/custom_configs/hyper_terminal/
# 3, Create the dir path /home/custom_configs/hyper_terminal/backround_images/


# 3, Copy all files from dir './run_on_startup/*' to /home/custom_configs/personal_computer_startup_scripts/hyper_terminal
# + This will result in all needed files within dir, including starup_terminals.sh 
# 5, Copy all files from ./backround_images/* to /home/custom_configs/hyper_terminal/backround_images/

# 4, Overwrite the file content ~/.hyper.js with  ./hyper_configs/hyper_custom_background.js

# 5, create the cronjob using cli, to auto start this file
# /home/custom_configs/personal_computer_startup_scripts/hyper_terminals/startup_terminals.sh

# Now the start_up terminal when being executed, aka this file it will correctly excute  the correct shs cripts
