#!/usr/bin/env bash
set -euo pipefail

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    # it assumes ssh key was copied from a pendrive to home folder
    if [ ! -f "$HOME/id_ed25519" ]; then
        echo "SSH private key not found at $HOME/id_ed25519"
        exit 0
    fi

    echo "--- Installing SSH key ---"
    mv "$HOME/id_ed25519" "$HOME/.ssh/id_ed25519"
    chmod 600 "$HOME/.ssh/id_ed25519"

    curl -fsSL https://github.com/ifdiego.keys \
        -o "$HOME/.ssh/id_ed25519.pub"

    eval "$(ssh-agent -s)"
    ssh-add "$HOME/.ssh/id_ed25519"

    ssh -T git@github.com || true
fi

if gh auth status >/dev/null 2>&1; then
    exit 0
fi

echo "--- Authenticating GitHub CLI ---"
gh auth login
