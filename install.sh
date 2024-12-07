#!/bin/bash

sudo pacman -S git
git clone https://github.com/ifdiego/dotfiles.git ~/dotfiles

cat ~/dotfiles/packages | sudo pacman -S --needed -
stow -d ~/dotfiles -t ~ .

# sudo cp ~/.etc/10-keyboard.conf /etc/X11/xorg.conf.d/10-keyboard.conf
sudo cp ~/.etc/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

chsh -s "$(which fish)"

sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker "$USER"

chmod 700 ~/.ssh
curl https://github.com/ifdiego.keys -o ~/.ssh/id_rsa.pub
ssh-add ~/.ssh/id_rsa
ssh -T git@github.com

chmod 700 ~/.gnupg
gpg --import public.asc # gpg --export --armor > public.asc
gpg --import private.asc # gpg --export-secret-keys --armor > private.asc
gpg --list-secret-keys --keyid-format=long

rustup default stable
mkdir -p ~/.cargo/bin

go install golang.org/x/tools/gopls@latest
rustup component add rust-analyzer
ln -s "$(rustup which rust-analyzer)" ~/.cargo/bin/rust-analyzer

git remote set-url origin git@github.com:ifdiego/dotfiles.git
xdg-user-dirs-update
