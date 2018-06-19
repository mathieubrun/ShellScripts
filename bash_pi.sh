#!/bin/bash

set -a

pi-ssh() {
    local host=raspberrypi.local
    if [[ $1 ]]; then
        host="192.168.1.$1"
    fi

    ssh pi@${host}
}

pi-ssh-copy() {
    local host=raspberrypi.local
    if [[ $1 ]]; then
        host="192.168.1.$1"
    fi

    cat ~/.ssh/pi.pub | ssh pi@${host} 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
}

pi-halt() {
    local host=raspberrypi.local
    if [[ $1 ]]; then
        host="192.168.1.$1"
    fi

    cat ~/.ssh/pi.pub | ssh pi@${host} 'sudo halt'
}

set +a