#!/bin/bash

echo "[INFO] Checking /home/$(whoami)/ links"

homefiles=$(find . -maxdepth 1 -type f -not -path "*.sh")
for file in $homefiles; do
    ln -i -s ~/dotfiles/"$file" ~/"$file"
done

echo "[INFO] Checking .config files"

configfiles=$(find .config/ -type f)
for file in $configfiles; do
    ln -i -s ~/dotfiles/"$file" ~/"$file"
done

if [ ! -d "${HOME}/.ssh" ]; then
    echo "[INFO] Creating /home/$(whoami)/.ssh"
    mkdir -p ~/.ssh
    ln -i -s ~/dotfiles/.ssh/config ~/.ssh/config
fi

if [ ! -d "${HOME}/.gnupg" ]; then
    echo "[INFO] Creating /home/$(whoami)/.gnupg"
    mkdir -p ~/.gnupg
    ln -i -s ~/dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf
fi

cp ~/dotfiles/.etc/10-keyboard.conf /etc/X11/xorg.conf.d/10-keyboard.conf
cp ~/dotfiles/.etc/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

chsh -s /usr/bin/fish
nvim +PackerSync

sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker "$USER"

rustup default stable

xdg-user-dirs-update
