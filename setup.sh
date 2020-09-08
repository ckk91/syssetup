#!/usr/bin/env bash
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
        nautilus-dropbox
        curl
        keepassxc
        git
        dolphin-plugins # todo if kde and homebox
        calibre         # todo if homebox
        htop
        flatpak
        plasma-discover-flatpak-backend
        krita
        thunderbird
        python3-pip
        filelight # todo if kde
        neovim-qt
        steam-installer
        virtualbox
    )
    apt install -y "${APT_PACKS[@]}"
}

function install_snaps() {
    # krita, blender if home
    snap install spotify krita
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

function install_ynab() {
    :
}

function install_chrome() {
    :
}

function install_clojure() {
    apt install -y clojure leiningen
}

function install_zsh() {
    sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
}

function setup_bash() {
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

function main() {
    #todo test if snap
    install_apt_packages
    install_snaps
    install_wine # if on home
    install_ynab # if on home
    install_chrome
    # install_clojure
    # install_zsh
    setup_bash
    # TODO if on home machine
    hook_nas
}
# todo check if sourced
#main
