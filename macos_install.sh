#!/bin/bash

# To run this script run `chmod +x macos_install.sh` and then `macos_install.sh`

# ----------------------------- SETUP SYMLINKS ------------------------------ #

# Backup existing files
echo "Backing up existing config files..."
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
[ -f ~/.zprofile ] && mv ~/.zprofile ~/.zprofile.bak
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak
[ -f ~/.gitconfig ] && mv ~/.gitconfig ~/.gitconfig.bak
[ -f ~/.gitignore_global ] && mv ~/.gitignore_global ~/.gitignore_global.bak

# Create symlinks
echo "Creating symlinks to dotfile configs..."
ln -s ~/dotfiles/shell/.zshrc ~/.zshrc    # .bashrc
echo "Symlink to .zshrc created."
ln -s ~/dotfiles/shell/.zprofile ~/.zprofile    # .bashrc
echo "Symlink to .zprofile created."
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc        # .vimcr
echo "Symlink to .vimrc created."
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
echo "Symlink to .gitconfig created."
ln -s ~/dotfiles/git/.gitignore_global ~/.gitignore_global
echo "Symlink to .gitignore_global created."
ln -s ~/dotfiles/shell/.tmux.conf ~/.tmux.conf
echo "Symlink to .tmux.config created."


# ------------------------------ INSTALL TOOLS ------------------------------ #

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing nvim"
brew install nvim
echo "Installing alacritty"
brew install alacritty
echo "Installing pyenv"
brew install pyenv
brew install pyenv-virtualenv

echo "Mapping nvim directories..."
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
ln -s ~/dotfiles/nvim ~/.config/nvim
echo "Mapping alacritty directories..."
[ -d ~/.config/alacritty ] && mv ~/.config/alacritty ~/.config/alacritty.bak
ln -s ~/dotfiles/alacritty ~/.config/alacritty

# -------------------------------- CLEAN UP --------------------------------- #

echo "Config complete."

echo "Please run 'source ~/.zshrc' to apply the changes immediately."
