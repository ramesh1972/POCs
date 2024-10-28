# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# copy all files from src to remote server using scp
echo "---------------------------------------------------"
echo "Deleting files to remote server"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "rm -rf $REMOTE_PATH"

echo "---------------------------------------------------"
echo "Creating remote root directory for $ENV"
echo  "SSH Command: ssh -i ${SSH_KEY} ${SSH_USER_HOST}"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "mkdir -p $REMOTE_PATH"

echo "---------------------------------------------------"
echo "Copying files to remote server - appServer"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "mkdir -p $REMOTE_PATH/appServer"
scp -i ${SSH_KEY} -r $SRC_PATH/appServer/* ${SSH_USER_HOST}:$REMOTE_PATH/appServer/

echo "---------------------------------------------------"
echo "Copying files to remote server - ui"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "mkdir -p $REMOTE_PATH/ui"
scp -i ${SSH_KEY} -r $SRC_PATH/ui/* ${SSH_USER_HOST}:$REMOTE_PATH/ui/

echo "---------------------------------------------------"
echo "Copying files to remote server - db"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "mkdir -p $REMOTE_PATH/db"
scp -i ${SSH_KEY} -r $SRC_PATH/db/* ${SSH_USER_HOST}:$REMOTE_PATH/db/

echo "---------------------------------------------------"
echo "Copying files to remote server - root folder"
scp -i ${SSH_KEY} $SRC_PATH/destiny* ${SSH_USER_HOST}:$REMOTE_PATH/
scp -i ${SSH_KEY} $SRC_PATH/docker-compose.yml ${SSH_USER_HOST}:$REMOTE_PATH/
scp -i ${SSH_KEY} $SRC_PATH/docker-compose-with-db.yml ${SSH_USER_HOST}:$REMOTE_PATH/