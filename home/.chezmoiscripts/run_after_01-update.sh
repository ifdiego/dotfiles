#!/usr/bin/env bash

if [ ! -f ~/.ssh/id_ed25519 ]; then
    mv ~/id_ed25519 ~/.ssh # it assumes ssh key was copied from a pendrive to home folder
    chmod 600 ~/.ssh/id_ed25519

    curl https://github.com/ifdiego.keys -o ~/.ssh/id_ed25519.pub

    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519

    ssh -T git@github.com || true
fi

if gh auth status >/dev/null 2>&1; then
    echo "GitHub CLI is authenticated"
else
    gh auth login
fi

gsettings set org.gnome.desktop.peripherals.keyboard delay 200
settings set org.gnome.desktop.peripherals.keyboard repeat-interval 10

curl -fsSL https://opencode.ai/install | bash
