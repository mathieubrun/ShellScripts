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