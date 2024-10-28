# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# arguments
# $1 - environment
REMOTE_PATH=/home/root/src/clients/webforless/destiny-limo-lms/$1/destiny-limo

echo "--------------------------------------------------------------------------------------------"
echo "Checking status of docker containers"
ssh ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose ps"

echo "--------------------------------------------------------------------------------------------"
echo "lsof"
ssh ${SSH_USER_HOST} "lsof -i -P -n" | grep LISTEN