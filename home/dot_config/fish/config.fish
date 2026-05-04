if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a g git
abbr -a d docker
abbr -a l less
abbr -a s sudo
abbr -a o xdg-open

abbr -a temp "pushd (mktemp -d)"
abbr -a rebuild "sudo nixos-rebuild switch"
abbr -a collect "sudo nix-collect-garbage -d"
abbr -a rsv "rsync -avh --info=progress2"
abbr -a tna "tmux new -A -s 0"
abbr -a tks "tmux kill-server"
abbr -a vimdiff "nvim -d"
abbr -a fd "fd --hidden"
abbr -a rr "rm -rf"
abbr -a gmt "go mod tidy"

abbr -a ga "git add"
abbr -a gb "git branch"
abbr -a gc "git commit"
abbr -a gco "git checkout"
abbr -a gd "git diff"
abbr -a gl "git log --oneline --graph"
abbr -a gla "git log --format='%an <%ae>' | sort -u"
abbr -a glh "git log -1 HEAD"
abbr -a gs "git status"

function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

function cdr
    cd $(git rev-parse --path-format=relative --show-toplevel)
end

function syu
    sudo pacman -Syu
    flatpak update
end

set -U fish_greeting

set -gx EDITOR hx
set -gx MANPAGER less #nvim +Man!

fish_add_path -p (go env GOPATH)/bin
fish_add_path -p ~/.cargo/bin
fish_add_path -p ~/.local/bin

direnv hook fish | source
fzf --fish | source
starship init fish | source
zoxide init fish | source
