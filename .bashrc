[[ $- != *i* ]] && return

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend
shopt -s cmdhist

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias more='less'
alias vi='vim'
alias open='xdg-open'

export PS1='\u@\h:\[\e[32m\]\w\[\e[0m\]$ '
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export EDITOR='vim'
