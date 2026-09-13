if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting # disable fish greeting

set -gx EDITOR hx
set -gx MANPAGER less #nvim +Man!
set -gx BAT_THEME "Catppuccin Macchiato"

fish_add_path -p (go env GOPATH)/bin
fish_add_path -p ~/.cargo/bin
fish_add_path -p ~/.local/bin
fish_add_path -p /var/home/diego/.opencode/bin
fish_add_path -a /home/linuxbrew/.linuxbrew/bin

abbr -a ... "cd ../.."
abbr -a .... "cd ../../.."
abbr -a ..... "cd ../../../.."
abbr -a temp "pushd (mktemp -d)"
abbr -a rebuild "sudo nixos-rebuild switch"
abbr -a collect "sudo nix-collect-garbage -d"
abbr -a update "rpm-ostree upgrade && flatpak update"
abbr -a dotfiles "git --git-dir=~/.dotfiles/ --work-tree=~"
abbr -a cdr "cd (git rev-parse --show-toplevel)"
abbr -a glf "git ls-files -z | xargs -0 du -b | sort -n"

function mkcd -d "Create a directory and change into it"
    mkdir -p $argv[1] && cd $argv[1]
end

mise activate fish | source
starship init fish | source
zoxide init fish | source
