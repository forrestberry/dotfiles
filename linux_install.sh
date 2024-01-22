#!/bin/bash

# To run this script run `chmod +x linux_install.sh` and then `linux_install.sh`

# ----------------------------- SETUP SYMLINKS ------------------------------ #

# Backup existing files
echo "Backing up existing config files..."
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak
[ -f ~/.gitconfig ] && mv ~/.gitconfig ~/.gitconfig.bak
[ -f ~/.gitignore_global ] && mv ~/.gitignore_global ~/.gitignore_global.bak

# Create symlinks
echo "Creating symlinks to dotfile configs..."
ln -s ~/dotfiles/shell/.bashrc ~/.bashrc    # .bashrc
echo "Symlink to .bashrc created."
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc        # .vimcr
echo "Symlink to .vimrc created."
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
echo "Symlink to .gitconfig created."
ln -s ~/dotfiles/git/.gitignore_global ~/.gitignore_global
echo "Symlink to .gitignore_global created."

# ------------------------------ INSTALL TOOLS ------------------------------ #

echo "Updating package lists..."
sudo apt-get update

echo "Installing vim..."
sudo apt-get install vim -y                 # vim

echo "Installing pyenv dependencies..."
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

curl https://pyenv.run | bash

echo 'Config complete. Run `exec "$SHELL"` to restart your terminal.'

