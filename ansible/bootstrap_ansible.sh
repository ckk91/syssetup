#!/usr/bin/env bash
#
# helper script to install ansible on machine.
# this enables us to further use ansible for workstation config


function main () {
    set -euo pipefail

    function finish () {
        
        if [ "$1" != "0" ]; then
            # where's the error?
            echo "Error $1 on line $2."
            # rollback/cleanup
        else
            : # all good
        fi
    }

    trap 'finish $? $LINENO' EXIT

    sudo apt-get install software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y ansible
    # for snaps
    ansible-galaxy collection install community.general
}


if [ "$0" = "$BASH_SOURCE" ] ; then
	main
fi