#!/usr/bin/env bash
set -eu

echo ""
if command -v brew &> /dev/null
then
    echo "Brew is already installed"
else
    echo "--- Installing brew ---"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install fish gopls zsh
fi
