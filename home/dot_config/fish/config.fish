set -gx EDITOR hx
# set -gx GPG_TTY (tty)
set -gx MANPAGER less #nvim +Man!

fish_add_path -a /home/linuxbrew/.linuxbrew/bin
fish_add_path -p (go env GOPATH)/bin
fish_add_path -p ~/.cargo/bin
fish_add_path -p /var/home/diego/.opencode/bin
fish_add_path -p ~/.local/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a g git
    abbr -a d docker
    abbr -a l less
    abbr -a s sudo
    abbr -a o xdg-open
    abbr -a vim nvim
    abbr -a ls eza
    abbr -a lg lazygit
    abbr -a oc opencode
    abbr -a cat bat
    abbr -a task go-task
    abbr -a temp "pushd (mktemp -d)"
    abbr -a rebuild "sudo nixos-rebuild switch"
    abbr -a collect "sudo nix-collect-garbage -d"
    abbr -a update "rpm-ostree upgrade && flatpak update"
    abbr -a rsv "rsync -avh --info=progress2"
    abbr -a tna "tmux new -A -s 0"
    abbr -a tks "tmux kill-server"
    abbr -a vimdiff "nvim -d"
    abbr -a fd "fd --hidden"
    abbr -a rr "rm -rf"
    abbr -a gmt "go mod tidy"
    abbr -a git-deletable-branches "git branch --merged | grep -v main"
    abbr -a ga "git add"
    abbr -a gb "git branch"
    abbr -a gc "git commit"
    abbr -a gco "git checkout"
    abbr -a gd "git diff"
    abbr -a gl "git log --oneline --graph"
    abbr -a gla "git log --format='%an <%ae>' | sort -u"
    abbr -a glh "git log -1 HEAD"
    abbr -a gs "git status"
    abbr -a tree "eza --tree --color=never"
    abbr -a ll "eza --long"
    abbr -a la "eza --long --all"

    set -U fish_greeting # disable fish greeting
    # set -g fish_color_autosuggestion blue
    # set -g fish_color_autosuggestion brgray --bold
    # set -g fish_color_autosuggestion brgray --underline
    # set -g fish_key_bindings fish_vi_key_bindings
    # fish_config prompt choose arrow

    fzf --fish | source
    export FZF_CTRL_T_OPTS="
        --walker-skip .git,node_modules,target
        --preview 'bat -n --color=always {}'
        --bind 'ctrl-/:change-preview-window(down|hidden|)'
        --bind 'ctrl-o:execute($EDITOR {} &> /dev/tty)'"

    direnv hook fish | source
    mise activate fish | source
    starship init fish | source
    zoxide init fish | source
end

function mkcd -d "Create a new directory and cd into it"
    mkdir -p $argv[1] && cd $argv[1]
end

function cdr -d "Change directory back to the root of the current repository"
    cd $(git rev-parse --path-format=relative --show-toplevel)
end

function syu -d "Update system and flatpaks"
    sudo pacman -Syu
    flatpak update
end

function git-file-sizes -d "List tracked Git files sorted by size"
    git ls-files -z | xargs -0 du -b | sort -n
end

function docker-prune-all-old -d "Remove unused Docker data older than 30 days"
    docker system prune --all --filter until=730h
end
