# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# arguments
# $1 - environment
REMOTE_PATH=/home/root/src/clients/webforless/destiny-limo-lms/$1/destiny-limo

echo "remote path: ${REMOTE_PATH}"

echo "--------------------------------------------------------------------------------------------"
echo "Shuting down docker images"
ssh ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose down"
echo "--------------------------------------------------------------------------------------------"

echo "Building docker images"
ssh ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose build"
echo "--------------------------------------------------------------------------------------------"

echo "Starting docker containers"
ssh ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose up -d"
echo "--------------------------------------------------------------------------------------------"

echo "Checking status of docker containers"
sh ../cmds/show-processes.sh ${ENV}
echo "--------------------------------------------------------------------------------------------"

echo "Restarted"
echo "--------------------------------------------------------------------------------------------"

echo "displaying output"
ssh ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose logs -f"