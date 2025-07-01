set fish_greeting
set EDITOR nvim
set MANPAGER less -Rc

abbr --add g "git"
abbr --add v "nvim"
abbr --add temp "pushd (mktemp -d)"
abbr --add ta "tmux new -A -s 0"
abbr --add ks "tmux kill-server"
abbr --add task "go-task"
abbr --add vim "nvim"
abbr --add vimdiff "nvim -d"

fish_add_path (go env GOPATH)/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

fish_config prompt choose astronaut

fzf --fish | source
go-task --completion fish | source
zoxide init fish | source
