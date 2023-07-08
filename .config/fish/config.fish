if status is-interactive
    # Commands to run in interactive sessions can go here
    set --global --export TERM xterm-256color
    set --global --export GPT_TTY (tty)
    set -U EDITOR nvim

    fish_add_path $HOME/go/bin
    fish_add_path $HOME/.cargo/bin

    alias vim='nvim'
    alias open='xdg-open'
    alias rsync='rsync -avh --info=progress2'
    alias temp='pushd $(mktemp -d)'
    alias nnn='nnn -adA'
    alias clipboard='xclip -in -selection clipboard'
    alias diff='colordiff'
end
