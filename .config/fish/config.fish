abbr --add gs "git status"
abbr --add gd "git diff"
abbr --add vim "nvim"
abbr --add temp "pushd (mktemp -d)"
abbr --add tree "eza --tree --color=never"
abbr --add ls "eza"
abbr --add ll "eza --long"
abbr --add la "eza --long --all"
abbr --add ta "tmux new -A -s default"

fish_add_path (go env GOPATH)/bin
fish_add_path ~/.cargo/bin

set --global fish_greeting
set --global fish_key_bindings fish_vi_key_bindings

set --global --export EDITOR nvim
set --global --export GPG_TTY (tty)
set --global --export MANPAGER nvim +Man!

function sesh-sessions
    set session (sesh list | fzf --height 40% --reverse --border-label ' sesh ')
    if test -z "$session"
        commandline -f repaint
        return
    end
    sesh connect $session
    commandline -f repaint
end

bind --mode insert \es sesh-sessions

fzf --fish | source
export FZF_CTRL_T_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --bind 'ctrl-o:execute($EDITOR {} &> /dev/tty)'"

starship init fish | source
zoxide init fish | source

if test (tty) = "/dev/tty1"
    exec Hyprland
end
