SSH_CMD="ssh -i ~/.ssh/ssh_keys/id_rsa_dl-lms root@172.235.16.212"

for image in $(docker images --format "{{.ID}}"); do
  echo "Image ID: $image"
  SSH_CMD "docker inspect --format='Command: {{.Config.Cmd}}, Ports: {{.Config.ExposedPorts}}' $image"
  echo "-----------------------------------"
done
