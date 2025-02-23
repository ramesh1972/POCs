# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# arguments
# $1 - environment
REMOTE_PATH=/var/www/html/prod//$1/destiny-limo
/var/www/html/mfe-poc/$ENV/react_micro_frontend_demo/

echo "--------------------------------------------------------------------------------------------"
echo "Checking status of docker containers"
ssh ${SSH_USER_HOST} "cd ${REMOTE_PATH} && docker compose ps"

echo "--------------------------------------------------------------------------------------------"
echo "lsof"
ssh ${SSH_USER_HOST} "lsof -i -P -n" | grep LISTEN