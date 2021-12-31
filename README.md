# Dotfiles

My configuration files for a linux setup.

## Installation

Clone this repo into `~/dotfiles`.

```
git clone git@github.com:ifdiego/dotfiles.git ~/dotfiles
```

Then link the dotfiles.

```
files=".bashrc .gitconfig .ssh/config .vimrc .tmux.conf .Xresources"

for file in $files; do
  rm -rf ~/$file
  ln -s ~/dotfiles/$file ~/$file
done

xrdb ~/.Xresources
source ~/.bashrc
```

## Vim

Uses `vim packages` for plugins.

Install packages.

```
mkdir -p ~/.vim/pack/plugins/start
git clone https://github.com/vim-python/python-syntax.git ~/.vim/pack/plugins/start/python-syntax
git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
git clone https://github.com/elixir-editors/vim-elixir.git ~/.vim/pack/plugins/start/vim-elixir
```

## Extras

On a new machine install tools with `pacman`.

```
sudo pacman -S \
  git curl vim tmux htop neofetch wget xterm nmap ffmpeg \
  firefox qbittorrent mpv simplescreenrecorder shotwell ttf-droid \
  rlwrap lsof jq tree xclip zathura zathura-pdf-poppler \
  base-devel go elixir clojure leiningen python-pip \
  docker docker-compose netcat
```
