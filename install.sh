#!/bin/bash

sudo pacman -Syu

sudo pacman -S git
sudo pacman -S curl
sudo pacman -S wget
sudo pacman -S vim
sudo pacman -S tmux

sudo pacman -S neofetch
sudo pacman -S jq
sudo pacman -S htop
sudo pacman -S nmap
sudo pacman -S ffmpeg
sudo pacman -S alacritty
sudo pacman -S rlwrap

sudo pacman -S firefox
sudo pacman -S qbittorrent
sudo pacman -S vlc
sudo pacman -S mpv
sudo pacman -S gthumb

sudo pacman -S base-devel
sudo pacman -S go
sudo pacman -S elixir
sudo pacman -S clojure

sudo pacman -Syu

cp .bashrc ~/.bashrc
cp .gitconfig ~/.gitconfig
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
clear
vim -c "PlugInstall" -c "q" -c "q"

source ~/.bashrc
