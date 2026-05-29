#!/usr/bin/env bash
set -eu

echo ""
if command -v zsh &> /dev/null
then
    echo "Oh My Zsh is already installed"
else
    echo "--- Installing Oh My Zsh ---"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://codeberg.org/ziglang/shell-completions $ZSH/custom/plugins/zig-shell-completions
fi
