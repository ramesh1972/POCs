# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# copy all files from src to remote server using scp
SSH_USER_HOST=root@172.235.16.212
ENV=prod
SRC_PATH=$1

echo "-----------> Copying Files to remote server on ${ENV} environment..."

# launch the base script
. ../base/_src-copy.sh

echo "-----------> Completed Copying Files to remote server on ${ENV} environment!"