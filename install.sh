#!/bin/bash

ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config
ln -sf ~/dotfiles/nvim ~/.config/nvim

echo "Done!"
