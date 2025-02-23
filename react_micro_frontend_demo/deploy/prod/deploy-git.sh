# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

SSH_USER_HOST=root@172.235.16.212
SSH_KEY=C:/Users/Dell/.ssh/ssh_keys/id_rsa_dl-lms
SSH_CMD="ssh -i ~/.ssh/ssh_keys/id_rsa_dl-lms root@172.235.16.212"
ENV=prod
SRC_PATH=../../../codebase/destiny-limo
GIT_USER=ramesh.viswanathan@hotmail.com
REPO_URL=https://github.com/ramesh1972/destinyLimo.git
BRANCH=master
REMOTE_PATH=/home/root/src/clients/webforless/destiny-limo-lms/$ENV/destiny-limo

# copy files
mkdir -p $SRC_PATH

echo "-----------> Deploying on remote server on ${ENV} environment..."

# launch the base script
. ../base/_deploy-git.sh

echo "-----------> Completed Deploying on remote server on ${ENV} environment!"