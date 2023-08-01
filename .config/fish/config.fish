set fish_greeting

set --global --export EDITOR nvim
set --global --export GPT_TTY (tty)
set --global --export LANG en_US.UTF-8
set --global --export LC_ALL en_US.UTF-8
set --global --export PAGER less
set --global --export TERM xterm-256color

fish_add_path /usr/local/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.cargo/bin

set --global --export hydro_color_pwd green

if status is-interactive
end
