#!/bin/sh

[[ -e ~/.xprofile ]] && . ~/.xprofile

xset r rate 200 70
xset -b
setxkbmap -option "ctrl:nocaps"

eval $(ssh-agent)

udiskie &
copyq &
flameshot &
redshift &
unclutter &

exec i3
