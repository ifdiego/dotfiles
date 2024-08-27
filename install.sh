#!/bin/bash

sudo pacman -S git
git clone https://github.com/ifdiego/dotfiles.git ~/dotfiles
sudo pacman -S --needed - < ~/dotfiles/.packages
cd ~/dotfiles
stow .

# sudo cp ~/.etc/10-keyboard.conf /etc/X11/xorg.conf.d/10-keyboard.conf
sudo cp ~/.etc/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

chsh -s "$(which fish)"

sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker "$USER"

git remote set-url origin git@github.com:ifdiego/dotfiles.git

rustup default stable
xdg-user-dirs-update
