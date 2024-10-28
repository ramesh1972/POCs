# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

SSH_USER_HOST=root@172.235.16.212
SSH_KEY=C:/Users/Dell/.ssh/ssh_keys/id_rsa_dl-lms
SRC_PATH=D:/src/clients/webforless/destinyLimo

read -p "Enter the env: " env
read -p "relative file path & name: " filePathName

REMOTE_PATH=/home/root/src/clients/webforless/destiny-limo-lms/$env/destiny-limo/$filePathName
SRC_PATH=$SRC_PATH/$filePathName

echo "SRC_PATH: $SRC_PATH"
echo "REMOTE_PATH: $REMOTE_PATH"

echo "---------------------------------------------------"
echo "Copying files to remote server"
scp -i ${SSH_KEY} $SRC_PATH ${SSH_USER_HOST}:$REMOTE_PATH
