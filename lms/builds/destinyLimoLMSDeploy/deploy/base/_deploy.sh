# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

echo "--------------------------------------------------------------------------------------------"
echo "Deploying to Linode"

echo "Shuting down docker images"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose down"
echo "--------------------------------------------------------------------------------------------"

echo "Building docker images"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose build"
echo "--------------------------------------------------------------------------------------------"

echo "Starting docker containers"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose up -d"
echo "--------------------------------------------------------------------------------------------"

echo "Checking status of docker containers"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose ps"
echo "--------------------------------------------------------------------------------------------"

echo "deployed to Linode"
echo "--------------------------------------------------------------------------------------------"

echo "displaying output"
ssh -i ${SSH_KEY} ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose logs -f"



