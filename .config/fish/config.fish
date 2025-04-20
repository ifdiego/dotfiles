if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr --add g "git"
abbr --add n "nvim"
abbr --add temp "pushd (mktemp -d)"
abbr --add ta "tmux new -A -s 0"
abbr --add ks "tmux kill-server"
abbr --add task "go-task"

fish_add_path (go env GOPATH)/bin
fish_add_path ~/.cargo/bin

set --global --export MANPAGER nvim +Man!

fzf --fish | source
go-task --completion fish | source
starship init fish | source
zoxide init fish | source
