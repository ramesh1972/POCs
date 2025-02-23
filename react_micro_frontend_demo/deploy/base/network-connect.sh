SSH_USER_HOST=root@172.235.16.212
SSH_KEY=C:/Users/Dell/.ssh/ssh_keys/id_rsa_dl-lms

echo "network-connect.sh:Current Directory: $PWD"

ssh -i ${SSH_KEY} ${SSH_USER_HOST} "docker network create mfe_network"

ssh -i ${SSH_KEY} ${SSH_USER_HOST} "docker network connect mfe_network mfe-reverse-proxy && docker network connect mfe_network usermanagement && docker network connect mfe_network dashboard && docker network connect mfe_network shared-micro-front-end-app && docker network connect mfe_network header && docker network connect mfe_network footer && docker network connect mfe_network host"
