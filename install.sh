#!/bin/bash

sudo apt update
sudo apt install \
  git curl wget vim \
  neofetch htop nmap \
  tmux ffmpeg qbittorrent \
  vlc gnome-tweaks \
  build-essential xsel \
  openssh-client

sudo apt update
sudo apt upgrade

cp .gitconfig ~/.gitconfig
cp .bashrc ~/.bashrc
cp .bash_aliases ~/.bash_aliases
cp .vim ~ -r
cp .vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
clear
vim -c "PlugInstall" -c "q" -c "q"

sudo apt update
sudo apt upgrade

source ~/.bashrc
