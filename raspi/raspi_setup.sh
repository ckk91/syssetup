#!/bin/bash

set -e

function system_upgrade {
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y
}

function docker_setup {
	which docker > /dev/null && return 0  # is already installed
	echo "docker setup"
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh  # todo make reentrant for ensuring the service starts after reboot
	sudo usermod -aG docker $USER
	docker run hello-world
	sudo apt install -y docker-compose
}

function docker_cleanup {
	echo "docker installation failed. cleaning up"
	rm "./get-docker.sh"
	}

function add_ext_hdd_to_fstab {
	grep -q "pi/extern" /etc/fstab && return 0  # bail early if exists
	echo "setting up mounts"
	mkdir -p $HOME/extern
	echo "# external hdd" | sudo tee -a /etc/fstab
	echo "/dev/sda1    /home/pi/extern    ext4    defaults,rw,nofail   0    1" | sudo tee -a /etc/fstab
	sudo mount -a
	# todo check for exist
	# todo fix perms
}
function add_nas_to_fstab {

}

function add_backports {
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC 648ACFD622F3D138
	echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list.d/buster-backports.list
	sudo apt update
	sudo apt install -t buster-backports libseccomp2
}

function setup_nextcloud {
#  sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./cert.key -out ./cert.crt
echo "setting up nextcloud"
mkdir -p $HOME/extern/nextcloud/data
mkdir -p $HOME/extern/nextcloud/config
cat << EOF >  ${HOME}/extern/nextcloud/docker-compose.yml
---
version: "2.1"
services:
  nextcloud:
    image: ghcr.io/linuxserver/nextcloud
    container_name: nextcloud
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - ./config:/config
      - ./data:/data
    ports:
      - 443:443
    restart: unless-stopped

EOF
echo "starting nextcloud"
pushd $HOME/extern/nextcloud
docker-compose up -d
popd
}
function move_docker_to_hdd {
	# todo add safeguard
	test -f /etc/docker/daemon.json && return 0
	echo "moving docker containers to external hdd"
	sudo service docker stop
	mkdir -p $HOME/extern/docker
	echo "{\"data-root\":\"$HOME/extern/docker\"}" | sudo tee -a /etc/docker/daemon.json  # single user only, lol
	sudo rsync -aP /var/lib/docker $HOME/extern/docker
	sudo mv /var/lib/docker /var/lib/docker.old
	sudo service docker start
	docker run hello-world && sudo rm -rf /var/lib/docker.old
}

function add_autostart_services {
	# todo nextcloud
}

function main {
	system_upgrade 
	add_ext_hdd_to_fstab
	add_nas_to_fstab
	docker_setup || docker_cleanup
	move_docker_to_hdd 
	add_backports
	setup_nextcloud 
	add_autostart_services
}

if [ "$0" = "$BASH_SOURCE" ] ; then
	main
fi
