set fish_greeting

set --global --export GPG_TTY (tty)
set --global --export MANPAGER less -F -X -R

fish_default_key_bindings

abbr --add gs "git status"
abbr --add gd "git diff"
abbr --add vim "nvim"
abbr --add temp "pushd (mktemp -d)"
abbr --add l "eza --long --sort date --reverse --color never"
abbr --add tree "eza --tree --color never"

fish_add_path (go env GOPATH)/bin
fish_add_path ~/.cargo/bin

zoxide init fish | source

# start x at login
if status is-login
and test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx -- -keeptty
end

if status is-interactive
and not set -q TMUX
    tmux has-session -t 0; and tmux attach-session -t 0; or tmux new-session -s 0;
end
