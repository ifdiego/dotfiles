#!/bin/bash

sudo pacman -S \
  git curl tmux htop neofetch \
  alacritty wget nmap ffmpeg \
  neovim lsof jq tree xclip

mkdir -p ~/.config/alacritty
mkdir -p ~/.config/nvim

files=".bashrc .gitconfig .ssh/config .vimrc .tmux.conf"

for file in $files; do
  rm -rf ~/$file
  ln -s ~/dotfiles/$file ~/$file
done

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c "PlugInstall" -c "q" -c "q"

source ~/.bashrc
