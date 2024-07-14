#!/bin/bash

#run with wget -qO - https://raw.githubusercontent.com/MachoDrone/PslssSd/main/psswrdlsssd.sh | sudo bash
# no reboot required

# sudoers entry
sudoers_entry="$USER ALL=(ALL) NOPASSWD:ALL"

# add the entry to sudoers using a temp file
temp_file=$(mktemp)
sudo cp /etc/sudoers $temp_file
echo "$sudoers_entry" | sudo tee -a $temp_file > /dev/null

# validate the sudoers file
sudo visudo -c -f $temp_file
if [ $? -eq 0 ]; then
    sudo cp $temp_file /etc/sudoers
    echo "Sudoers file updated successfully."
else
    echo "Error: Invalid sudoers file. Changes were not applied."
fi

# clean up temp file
rm $temp_file
