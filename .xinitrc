#!/bin/sh

[[ -e ~/.xprofile ]] && . ~/.xprofile

xset r rate 300 80
xset -b

eval $(ssh-agent)

udiskie &
copyq &
flameshot &
redshift &
unclutter &

exec i3
