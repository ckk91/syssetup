#!/usr/bin/env bash
# System setup script/playground
#
# TODO: flags?a cleanup


set -euo pipefail
IFS=$'\n\t'

# to pull: bash -c "$(wget $URL -O -)"
# ============================================
# https://medium.com/better-programming/best-practices-for-bash-scripts-17229889774d
# run with sudo
function install_apt_packages() {
    add-apt-repository -y ppa:kritalime/ppa

    apt update && apt upgrade

    APT_PACKS=(
        # ag  # todo ripgrep
        aptitude
        build-essential
        calibre         # todo if homebox
        curl
        dolphin-plugins # todo if kde and homebox
        filelight # todo if kde
        flatpak
        git
        htop
        keepassxc
        krita
        nautilus-dropbox
        neovim-qt
        plasma-discover-flatpak-backend
        python3-pip
        steam-installer
        thunderbird
        virtualbox
        # fresh and hot
        ranger  # todo evaluate tool
        tig  # todo evaluate tool
    )
    apt install -y "${APT_PACKS[@]}"
}

function install_snaps() {
    snap install spotify
    snap install --classic blender code
}

# TODO dolphin plugins setup for dropbox
function install_wine() { # if home
    dpkg --add-architecture i386
    wget -O - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
    add-apt-repository 'https://dl.winehq.org/wine-builds/ubuntu/' &&
        apt update
    apt install -y winehq-stable
}

function install_chrome() {
    :
}

function install_docker() {
    :
}

function hook_nas() {
    # todo if on home
    # create folder
    mkdir -p /media/nas
    # install cifs
    apt-get install -y cifs-utils
    # update fstab
    # TODO
}
function install_zsh {
    if [ "${SHELL}" != "/usr/bin/zsh" ]; then
        echo "Setting up zsh"
        sudo apt-get install -y zsh
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        exit 0
    fi
}
function install_python_venv {
    if [ ! -d $HOME/.pyenv ]; then
        echo "Setting up pyenv"
        curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | zsh

        echo 'export PATH="/home/fia/.pyenv/bin:$PATH"' >> ~/.zshrc
        echo 'eval "$(pyenv init -)"' >> ~/.zshrc
        echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
        # . $HOME/.zshrc
    fi
}
function install_nvm () {
    if [ ! -d $HOME/.nvm ]; then
        echo "Setting up nvm and nodejs lvm latest"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh
        . $HOME/.zshrc
        nvm install --lts
    fi
}

function main() {
    :
    #todo test if snap
    # install_apt_packages
    # install_snaps
    # install_wine # if on home
    # install_ynab # if on home
    # install_chrome
    # setup_bash
    # TODO if on home machine
    # hook_nas
}
# todo check if sourced
#main
