# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# copy all files from src to remote server using scp
echo "---------------------------------------------------"
echo "Deleting files to remote server"
echo "SSH Command: ssh -i ${SSH_KEY} ${SSH_USER_HOST}"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "rm -rf $REMOTE_PATH"

echo "---------------------------------------------------"
echo "Creating remote root directory for $ENV"
echo  "SSH Command: ssh -i ${SSH_KEY} ${SSH_USER_HOST}"
echo  "mkdir -p $REMOTE_PATH"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "mkdir -p $REMOTE_PATH"

echo "---------------------------------------------------"
echo "Copying files to remote server"
scp -i ${SSH_KEY} -r $SRC_PATH/* ${SSH_USER_HOST}:$REMOTE_PATH/

echo "---------------------------------------------------"
echo "Copying files to remote server - root folder"
#scp -i ${SSH_KEY} $SRC_PATH/* ${SSH_USER_HOST}:$REMOTE_PATH/