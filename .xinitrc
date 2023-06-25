#!/bin/sh

[[ -e ~/.xprofile ]] && . ~/.xprofile
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# xautolock -time 10 -locker slock &

eval $(ssh-agent)

udiskie &
copyq &
flameshot &

exec i3
