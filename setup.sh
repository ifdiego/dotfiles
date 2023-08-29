#!/bin/bash

chsh -s /usr/bin/fish

cp ~/dotfiles/.etc/10-keyboard.conf /etc/X11/xorg.conf.d/10-keyboard.conf
cp ~/dotfiles/.etc/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

mkdir -p ~/.gnupg
mkdir -p ~/.ssh

ln -i -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -i -s ~/dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf
ln -i -s ~/dotfiles/.packages ~/.packages
ln -i -s ~/dotfiles/.ssh/config ~/.ssh/config
ln -i -s ~/dotfiles/.xinitrc ~/.xinitrc
ln -i -s ~/dotfiles/.xprofile ~/.xprofile

files=`find .config/ -type f`
for file in $files; do
    ln -i -s ~/dotfiles/$file ~/$file
done

nvim +PackerSync

sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker $USER

xdg-user-dirs-update
