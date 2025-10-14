#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles..."
echo "Platform: $(uname -s)"

# Universal configs (work everywhere)
echo "→ Installing universal configs..."
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/nvim" ~/.config/nvim
echo "  ✓ zsh, nvim"

# macOS-specific configs
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "→ Installing macOS-specific configs..."
    ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
    ln -sf "$DOTFILES_DIR/.aerospace.toml" ~/.aerospace.toml
    ln -sf "$DOTFILES_DIR/kanata.kbd" ~/.config/kanata.kbd
    mkdir -p ~/.config/alacritty
    ln -sf "$DOTFILES_DIR/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
    echo "  ✓ tmux, aerospace, kanata, alacritty"
fi

# Install LSP servers for Neovim
echo ""
echo "→ Installing LSP servers..."
if command -v npm &> /dev/null; then
    npm install -g yaml-language-server vscode-langservers-extracted
    echo "  ✓ yamlls, jsonls installed"
else
    echo "  ⚠ npm not found, skipping LSP server installation"
    echo "  Install manually: npm install -g yaml-language-server vscode-langservers-extracted"
fi

# Change default shell to zsh if not already
if [[ "$SHELL" != */zsh ]]; then
    echo ""
    echo "→ Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo "  ✓ Default shell changed to zsh"
fi

echo ""
echo "✓ Done! Restart your shell or run: source ~/.zshrc"
