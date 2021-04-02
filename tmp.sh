#!/usr/bin/env bash

set -e

# dir setup
if [ ! -d $HOME/00_env ]; then
    mkdir -p $HOME/00_env
fi
# system refresh
echo "updating system"
sudo apt-get update
# zsh setup
if [ "${SHELL}" != "/usr/bin/zsh" ]; then
    echo "Setting up zsh"
    sudo apt-get install -y zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    exit 0
fi

# python venv
if [ ! -d $HOME/.pyenv ]; then
    echo "Setting up pyenv"
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | zsh

    echo 'export PATH="/home/fia/.pyenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
    . $HOME/.zshrc
fi

if [ ! -d $HOME/.nvm ]; then
    echo "Setting up nvm and nodejs lvm latest"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh
    . $HOME/.zshrc
    nvm install --lts
fi
