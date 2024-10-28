#!/bin/bash

KEY_NAME="id_rsa"
KEY_PATH="$HOME/.ssh/$KEY_NAME"
REMOTE_USER="trigent1"
REMOTE_HOST="10.0.0.208"
REMOTE_PORT="22" # Default SSH port
REMOTE_DIR="/home/$REMOTE_USER/.ssh"
LOCAL_COPY_DIR="$HOME/.ssh/ssh_keys" # Local directory to copy the key to

# generate_ssh_key
generate() {
    local key_path="$1"
    local email="$2"
    local remote_user="$3"
    local remote_host="$4"

    # Step 1: Generate SSH Key
    mkdir -p ~/.ssh/ssh_keys
    if [ -f "$key_path" ]; then
        echo "SSH key $key_path already exists."
    else
        echo "Generating SSH key..."
        ssh-keygen -t rsa -b 4096 -f "$key_path" -N "" -C "$email" -N "" # No passphrase
    fi

    # copy the keys
    cp $key_path ~/.ssh/ssh_keys
    cp $key_path.pub ~/.ssh/ssh_keys

    # Step 2: Copy SSH Key to Remote Machine
    echo "Copying SSH key to remote machine $remote_user@$remote_host..."
    ssh-copy-id -f -i "$key_path.pub" -p "$REMOTE_PORT" "$remote_user@$remote_host"

    # Step 3: Verify Key Setup on Remote Machine
    echo "Verifying SSH key setup on remote machine..."
    ssh -i "$key_path" -p "$REMOTE_PORT" "$remote_user@$remote_host" "echo 'SSH key successfully installed on remote machine!'"
}

# Function to generate SSH key
generate_ssh_key() {
    local key_path="$1"
    local email="$2"

    echo "Generating SSH key for $email..."
    ssh-keygen -t rsa -b 4096 -C "$email" -f "$key_path" -N ""  # No passphrase

    cp $key_path ~/.ssh/ssh_keys
    cp $key_path.pub ~/.ssh/ssh_keys
}

# Function to copy SSH key to remote machine
copy_ssh_key_to_remote() {
    local key_path="$1"
    local remote_user="$2"
    local remote_ip="$3"

    echo "Copying SSH key to $remote_user@$remote_ip..."
    ssh-copy-id -i "$key_path.pub" "$remote_user@$remote_ip"
}

# Function to add an entry to the SSH config file
add_to_ssh_config() {
    local remote_user="$1"
    local remote_ip="$2"
    local key_path="$3"
    local config_file="$HOME/.ssh/config"

    # Check if the config file exists, if not create it
    if [ ! -f "$config_file" ]; then
        touch "$config_file"
        chmod 600 "$config_file"
    fi

    # Check if an entry already exists for this host
    if grep -q "Host $remote_ip" "$config_file"; then
        echo "An entry for $remote_ip already exists in $config_file. Skipping..."
    else
        echo "Adding entry to $config_file for $remote_user@$remote_ip..."
        echo -e "\nHost $remote_ip\n\tUser $remote_user\n\tIdentityFile $key_path\n\tStrictHostKeyChecking no" >> "$config_file"
        echo "Entry added."
    fi
}

# Main function to handle multiple users and machines
main() {
    while true; do
        read -p "Enter the remote username (or 'done' to finish): " remote_user
        [[ "$remote_user" == "done" ]] && break

        read -p "Enter the IP address of the remote machine: " remote_ip
        read -p "Enter a phrase to identify this key (no spaces, small caps): " key_phrase
        read -p "Enter the email associated with this key: " email

        key_path="$HOME/.ssh/id_rsa_${key_phrase}"

        echo "key_path: $key_path"

        #generate "$key_path" "$email" "$remote_user" "$remote_ip"

        #Generate SSH key for the user
        generate_ssh_key "$key_path" "$email"

        # # Copy the key to the remote machine
        copy_ssh_key_to_remote "$key_path" "$remote_user" "$remote_ip"

        # Add an entry to the SSH config file
        add_to_ssh_config "$remote_user" "$remote_ip" "$key_path"

        # echo "SSH key setup complete for $remote_user@$remote_ip"
        echo
    done

    echo "All SSH keys have been generated, copied, and SSH config entries created!"
}

# Run the main function
main