# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

SSH_USER_HOST=ubuntu@3.147.142.202
SSH_KEY=C:/Users/Dell/.ssh/ssh_keys/id_rsa_c
ENV=prod
SRC_PATH=D:/__src/github-ramesh/POCs/lms/destinyLimo
REMOTE_PATH=/home/chordify-services/lms-poc/${ENV}

# copy files
./src-copy.sh $SSH_USER_HOST $SSH_KEY $SRC_PATH $REMOTE_PATH $ENV   

echo "-----------> Deploying on remote server on ${ENV} environment..."

# launch the base script
. ../base/_deploy.sh

echo "-----------> Completed Deploying on remote server on ${ENV} environment!"