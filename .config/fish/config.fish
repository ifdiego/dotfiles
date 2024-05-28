abbr --add gs git status
abbr --add n $EDITOR
abbr --add temp pushd (mktemp -d)
abbr --add ll ls -lh

set fish_greeting

set --global --export EDITOR nvim
set --global --export GOPATH (go env GOPATH)
set --global --export CARGO_HOME $HOME/.cargo
set --global --export GPG_TTY (tty)

set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

fish_add_path $GOPATH/bin
fish_add_path $CARGO_HOME/bin

# fish integration for direnv
direnv hook fish | source

# start x at login
if status is-login
and test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx -- -keeptty
end

if status is-interactive
and not set -q TMUX
    tmux has-session -t 0; and tmux attach-session -t 0; or tmux new-session -s 0;
end
