#!/bin/bash

# Install packages
sudo apt update
sudo apt install -y zsh neovim tmux git curl

# Create symlinks
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Change shell
sudo chsh -s /usr/bin/zsh $USER

echo "Done! Restart your shell"
