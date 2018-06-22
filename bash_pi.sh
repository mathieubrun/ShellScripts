#!/bin/bash

pi_ssh_copy_keys() {
    if [[ ! -f ~/.ssh/pi.pub ]]; then
        ssh-keygen -b 2048 -t rsa -f ~/.ssh/pi -q -N ""
    fi

    ssh-copy-id -i ~/.ssh/pi.pub pi@$1
}

pi_docker_copy() {
    docker save $1 | gzip | ssh $2 'docker load'
}

pi_halt() {
    ssh $1 'sudo halt'
}

pi_change_hostname() {
    ssh -t $1 NEW_HOST=$2 'bash -s' <<'ENDSSH'
sudo sed -i "s/$(hostname)/$NEW_HOST/g" /etc/hostname
sudo sed -i "s/$(hostname)/$NEW_HOST/g" /etc/hosts
sudo hostnamectl set-hostname "$NEW_HOST"
sudo systemctl restart avahi-daemon
ENDSSH
}