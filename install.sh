#!/bin/bash

sudo pacman -S git
git clone https://github.com/ifdiego/dotfiles.git ~/dotfiles

cat ~/dotfiles/packages | sudo pacman -S --needed -
cd ~/dotfiles
stow .

# sudo cp ~/.etc/10-keyboard.conf /etc/X11/xorg.conf.d/10-keyboard.conf
sudo cp ~/.etc/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

chsh -s "$(which fish)"

sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker "$USER"

rustup default stable
mkdir -p .cargo/bin

go install golang.org/x/tools/gopls@latest
rustup component add rust-analyzer
ln -s "$(rustup which rust-analyzer)" ~/.cargo/bin/rust-analyzer

git remote set-url origin git@github.com:ifdiego/dotfiles.git
xdg-user-dirs-update
