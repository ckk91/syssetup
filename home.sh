#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function create_default_folders() {
    mkdir -p ~/dev ~/00_my
}

function setup_git() {
    git config --global user.email "${GIT_EMAIL}"
    git config --global user.name "${GIT_USER}"
}

# todo theme install
function setup_tbird() {
    :
}
# todo setup vscode plugins
function setup_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}
function setup_vorta() {
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub com.borgbase.Vorta
}
function setup_python () {
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    echo 'export PATH="/home/fia/.pyenv/bin:$PATH"' >>~/.bashrc
    echo 'eval "$(pyenv init -)"' >>~/.bashrc
    echo 'eval "$(pyenv virtualenv-init -)"' >>~/.bashrc
}

function main() {
    create_default_folders
    setup_git
    setup_python
    setup_tbird
    setup_rust
    setup_vorta
}
