#!/bin/bash

sudo pacman -S \
  git curl vim tmux htop neofetch wget xterm nmap ffmpeg \
  firefox qbittorrent mpv simplescreenrecorder shotwell ttf-droid \
  rlwrap lsof jq tree xclip zathura zathura-pdf-poppler \
  base-devel go elixir clojure leiningen python-pip

files=".bashrc .gitconfig .ssh/config .vimrc .tmux.conf .Xresources"

for file in $files; do
  ln -s ~/dotfiles/$file ~/$file
done

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c "PlugInstall" -c "q" -c "q"

xrdb ~/.Xresources

source ~/.bashrc
