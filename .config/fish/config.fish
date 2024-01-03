set --global --export GOPATH $HOME/go
set --global --export GOBIN $GOPATH/bin
set --global --export CARGO_HOME $HOME/.cargo
set --global --export EDITOR nvim
set --global --export GPG_TTY (tty)
set --global --export MANPAGER less -FirSwX

fish_add_path $GOBIN
fish_add_path $CARGO_HOME/bin
fish_add_path $CARGO_HOME/env
fish_add_path /usr/local/bin

set fish_greeting
set fish_vi_key_bindings

set __fish_git_prompt_showdirtystate "yes"
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles "yes"
set __fish_git_prompt_showcolorhints

abbr -a gs git status
abbr -a n $EDITOR
abbr -a temp pushd (mktemp -d)

# fish integration for direnv
direnv hook fish | source

set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

# start x at login
if status is-login
and test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx -- -keeptty
end

if status is-interactive
and not set -q TMUX
    tmux has-session -t 0; and tmux attach-session -t 0; or tmux new-session -s 0;
end
