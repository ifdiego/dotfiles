#
# ~/.bash_profile
#

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export PS1='[\u@\h \W]\$ '
