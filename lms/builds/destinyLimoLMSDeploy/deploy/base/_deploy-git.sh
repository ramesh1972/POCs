# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

CURRENT_PATH=$(pwd)

# git creds
echo "----------> logging into git..."
git config --global user.email ${GIT_USER}

# Clone the repository
echo "----------> Cloning the repository..."
git clone ${REPO_URL} ${SRC_PATH}

# Change to the project directory
mkdir -p ${SRC_PATH}
cd ${SRC_PATH}

# checkout the UI branch
echo "----------> fetching latest ${ENV} code from repository..."
git checkout ${BRANCH}
git pull origin ${BRANCH}

echo "--------------------------------------------------------------------------------------------"
echo "Copying Files to remote server on ${ENV} environment..."
cd ${CURRENT_PATH}
cd ..
cd base
echo "PWD: $PWD"

. ./_src-copy.sh

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



