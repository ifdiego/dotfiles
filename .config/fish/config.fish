if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
set EDITOR hx

abbr --add temp "pushd (mktemp -d)"
abbr --add rebuild "sudo nixos-rebuild switch"
abbr --add collect "sudo nix-collect-garbage -d"

fish_add_path (go env GOPATH)/bin
fish_add_path ~/.cargo/bin

fish_config prompt choose arrow

fzf --fish | source
zoxide init fish | source
