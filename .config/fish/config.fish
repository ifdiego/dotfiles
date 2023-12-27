set --global --export EDITOR nvim
set --global --export CARGO_HOME $HOME/.cargo
set --global --export GOPATH $HOME/go
set --global --export GOBIN $GOPATH/bin
set --global --export GPG_TTY (tty)
set --global --export LANG en_US.UTF-8
set --global --export LC_ALL en_US.UTF-8
set --global --export MANPAGER less -FirSwX
set --global --export TERM xterm-256color

fish_add_path /usr/local/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/bin
fish_add_path $GOBIN
fish_add_path $CARGO_HOME/bin
fish_add_path $CARGO_HOME/env

set fish_greeting
set fish_vi_key_bindings

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate "yes"
set -g __fish_git_prompt_showuntrackedfiles "yes"
set -g __fish_git_prompt_char_stateseparator " "
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch magenta
