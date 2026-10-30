#!/usr/bin/env bash
set -euo pipefail

flatpak remote-add --if-not-exists flathub \
    https://dl.flathub.org/repo/flathub.flatpakrepo

curl https://mise.run | sh
mise bootstrap --yes

curl -sL https://git.io/fisher | source
fisher update

gh auth login

gsettings set org.gnome.desktop.peripherals.keyboard delay 200
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 10

chsh -s "$(which fish)"
