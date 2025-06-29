# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# copy all files from src to remote server using scp
SSH_USER_HOST=$1
SSH_KEY=$2
SRC_PATH=$3
REMOTE_PATH=$4
ENV=$5

echo "-----------> Copying Files to remote server on ${ENV} environment..."
echo "SRC_PATH: $SRC_PATH"
echo "REMOTE_PATH: $REMOTE_PATH"
echo "SSH_USER_HOST: $SSH_USER_HOST"
echo "SSH_KEY: $SSH_KEY"
echo "ENV: $ENV"
echo "---------------------------------------------------"
# launch the base script
. ../base/_src-copy.sh

echo "-----------> Completed Copying Files to remote server on ${ENV} environment!"