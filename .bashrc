alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias vi='vim'
alias open='xdg-open'
alias rsync="rsync -avh --info=progress2"

export PS1='\[\e[1;32m\]\w\[\e[1;34m\]$(__git_ps1 " (%s)")\[\e[0m\] '
export EDITOR='vim'
export GPG_TTY=$(tty)
export GIT_PS1_SHOWDIRTYSTATE=true

source /usr/share/git/completion/git-prompt.sh
