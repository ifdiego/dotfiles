#!/bin/bash

sudo pacman -S git
git clone https://github.com/ifdiego/dotfiles.git ~/dotfiles

cat ~/dotfiles/packages | sudo pacman -S --needed -
stow -d ~/dotfiles -t ~ .

chsh -s "$(which fish)"
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher update

sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker "$USER"

chmod 700 ~/.ssh
curl https://github.com/ifdiego.keys -o ~/.ssh/id_ed25519.pub
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default stable
mkdir -p ~/.cargo/bin

go install golang.org/x/tools/gopls@latest
go install github.com/joshmedeski/sesh@latest
rustup component add rust-analyzer
ln -s "$(rustup which rust-analyzer)" ~/.cargo/bin/rust-analyzer

git remote set-url origin git@github.com:ifdiego/dotfiles.git
xdg-user-dirs-update
