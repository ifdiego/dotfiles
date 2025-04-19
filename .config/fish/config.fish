abbr --add gs "git status"
abbr --add gd "git diff"
abbr --add vim "nvim"
abbr --add temp "pushd (mktemp -d)"
abbr --add tree "eza --tree --color=never"
abbr --add ls "eza"
abbr --add ll "eza --long"
abbr --add la "eza --long --all"
abbr --add ta "tmux new -A -s 0"
abbr --add cat "bat"
abbr --add task "go-task"

fish_add_path (go env GOPATH)/bin
fish_add_path ~/.cargo/bin

set --global --export MANPAGER nvim +Man!

fish_config prompt choose arrow

fzf --fish | source
go-task --completion fish | source
zoxide init fish | source
