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

# todo add pandoc && sudo apt-get install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
# todo add python-pip3 if ubuntu and install ipython. (after pyenv setup!)

function install_apt_packages() {
    # add-apt-repository -y ppa:kritalime/ppa

    apt update && apt upgrade

    APT_PACKS=(
        # ag  # todo ripgrep
        aptitude
        build-essential
        curl
        git
        htop
        locate
        neovim-qt
        ranger  # todo evaluate tool
        tig  # todo evaluate tool
    )
    apt install -y "${APT_PACKS[@]}"
}


function create_git_ssh_key () {
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -P "" -f $SSH_FILE -q
}


function install_zsh {
    if [ "${SHELL}" != "/usr/bin/zsh" ]; then
        echo "Setting up zsh"
        sudo apt-get install -y zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        # todo remind to change shell
        chsh /usr/bin/zsh
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
    install_apt_packages
    install_snaps
    install_zsh
    install_python_venv
    install_nvm
    # create_git_ssh_key  # todo
}

if [ "$0" = "$BASH_SOURCE" ]; then
    main
fi

# todo cat vscode_extensions.list | grep -v '^#' | xargs -L1 code --install-extension