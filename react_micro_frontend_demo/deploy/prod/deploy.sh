# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

SSH_USER_HOST=root@172.235.16.212
SSH_KEY=C:/Users/Dell/.ssh/ssh_keys/id_rsa_dl-lms
SSH_CMD="ssh -i ~/.ssh/ssh_keys/id_rsa_dl-lms root@172.235.16.212"

ENV=prod
SRC_PATH=D:/src/github-ramesh/examples/micro-front-end/react_micro_frontend_demo/
REMOTE_PATH=/var/www/html/mfe-poc/$ENV/react_micro_frontend_demo/

# clean up local files
rm -rf $SRC_PATH/shared-micro-front-end-app/node_modules
rm -rf $SRC_PATH/shared-micro-front-end-app/dist

rm -rf $SRC_PATH/dashboard/node_modules
rm -rf $SRC_PATH/dashboard/dist

rm -rf $SRC_PATH/userManagement/node_modules
rm -rf $SRC_PATH/userManagement/dist

rm -rf $SRC_PATH/footer/node_modules
rm -rf $SRC_PATH/footer/dist

rm -rf $SRC_PATH/header/node_modules
rm -rf $SRC_PATH/header/dist

rm -rf $SRC_PATH/host/node_modules
rm -rf $SRC_PATH/host/dist

# copy files
. ./src-copy.sh $SRC_PATH

echo "-----------> Deploying on remote server on ${ENV} environment..."

# launch the base script
. ../base/_deploy.sh

echo "-----------> Completed Deploying on remote server on ${ENV} environment!"