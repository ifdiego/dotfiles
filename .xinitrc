#!/bin/sh

[[ -e ~/.xprofile ]] && . ~/.xprofile

xset r rate 300 80
xset -b
setxkbmap -option caps:swapescape

eval $(ssh-agent)

udiskie &
copyq &
flameshot &
redshift &
unclutter &

exec i3
