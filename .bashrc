alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias open='xdg-open'
alias rsync='rsync -avh --info=progress2'
alias temp='pushd $(mktemp -d)'
alias nnn='nnn -adA'
alias clipboard='xclip -in -selection clipboard'
alias diff='colordiff'

export PS1='\[\e[1;32m\]\w\[\e[1;34m\]$(__git_ps1 " (%s)")\[\e[0m\] '
export EDITOR='nvim'
export GPG_TTY=$(tty)
export GIT_PS1_SHOWDIRTYSTATE=true
export CLICOLOR=TRUE
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

source /usr/share/git/completion/git-prompt.sh
