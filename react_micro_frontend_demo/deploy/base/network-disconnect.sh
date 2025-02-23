SSH_USER_HOST=root@172.235.16.212
SSH_KEY=C:/Users/Dell/.ssh/ssh_keys/id_rsa_dl-lms

echo "network-disconnect.sh:Current Directory: $PWD"

ssh -i ${SSH_KEY} ${SSH_USER_HOST} "docker network disconnect mfe_network mfe-reverse-proxy && docker network disconnect mfe_network usermanagement && docker network disconnect mfe_network dashboard && docker network disconnect mfe_network shared-micro-front-end-app && docker network disconnect mfe_network header && ocker network disconnect mfe_network footer && docker network disconnect mfe_network host"

ssh -i ${SSH_KEY} ${SSH_USER_HOST} "docker network rm mfe_network"

ssh -i ${SSH_KEY} ${SSH_USER_HOST} "docker network ls"