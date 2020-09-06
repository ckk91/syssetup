#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# to pull: bash -c "$(wget $URL -O -)"
# ============================================


function create_default_folders() {
mkdir ~/dev ~/00_my    
}

function install_apt_packages {   
sudo apt update && sudo apt upgrade

APT_PACKS=(
    ag
    aptitude
    build-essential
    curl
    git
    htop
    neovim-qt
    steam-installer
    virtualbox
)
sudo apt install -y ${APT_PACKS[@]}
}

function install_snaps {
    SNAPS=(
	spotify
	krita
    )
    sudo snap install ${SNAPS[@]}
    sudo snap install --classic blender code emacs
}

function install_wine {
    sudo dpkg --add-architecture i386
    wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
    sudo add-apt-repository 'https://dl.winehq.org/wine-builds/ubuntu/' \
	&& sudo apt update
    sudo apt install -y winehq-stable
}

function install_ynab {
    
}

function install_chrome {
    
}

function install_clojure {
  sudo apt install -y clojure leiningen    
}

function install_zsh {
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
echo 'export PATH="/home/fia/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
}

function setup_bash {
    
}

function setup_emacs {
git clone https://github.com/CKMakesStuff/emacs.d.git ~/.emacs.d
}

function setup_python {
sudo apt install -y python3-pip
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
}
function update_fstab {
    
}
function main {
    create_default_folders
    install_apt_packages
    install_snaps
    install_wine
    install_ynab
    install_chrome
    # install_clojure
    # install_zsh
    setup_bash
    setup_emacs
    setup_python
    # TODO if on home machine
    update_fstab
}
