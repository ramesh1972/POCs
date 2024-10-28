#!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# Variables
REMOTE_USER="root"
REMOTE_HOST="172.235.16.212"
REMOTE_PORT="22" # Default SSH port
REMOTE_DIR="/home/$REMOTE_USER/.ssh"

KEY_NAME="$(whoami)_${REMOTE_USER}_${REMOTE_HOST}_rsa"
echo "-----------------> KEY_NAME: $KEY_NAME"

LOCAL_KEY_PATH="$HOME/.ssh/ssh_keys" # Local directory to copy the key to
LOCAL_KEY_PATH_NAME="$LOCAL_KEY_PATH/$KEY_NAME"
echo "-----------------> LOCAL_KEY_PATH_NAME: $LOCAL_KEY_PATH_NAME"

# Step 1: Create Local Directory to Copy the Key (if it doesn't exist)
if [ ! -d "$LOCAL_KEY_PATH" ]; then
    echo "Creating local directory to copy the SSH key..."
    mkdir -p "$LOCAL_KEY_PATH"
fi

# Step 2: Generate SSH Key
echo "Generating SSH key..."
ssh-keygen -t rsa -b 4096 -f "$LOCAL_KEY_PATH_NAME" -N "" -C "$(whoami)@$(hostname)"

# Step 3: Copy SSH Key to Remote Machine
echo "Copying SSH key to remote machine $REMOTE_USER@$REMOTE_HOST..."
ssh-copy-id -f -i "$LOCAL_KEY_PATH_NAME" -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST"

# Step 5: Verify Key Setup on Remote Machine
echo "Verifying SSH key setup on remote machine..."
ssh -i "$LOCAL_KEY_PATH_NAME" -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "echo 'SSH key successfully installed on remote machine!'"

echo "Done!"
