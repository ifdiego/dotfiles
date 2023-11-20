#!/bin/sh

 # [[ -e ~/.xprofile ]] && . ~/.xprofile
# [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
#
# if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#     for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#         [ -x "$f" ] && . "$f"
#     done
#     unset f
# fi

xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync &
sleep 1
xrandr --addmode eDP1 1920x1080_60.00 &
sleep 1
xrandr --output eDP1 --mode 1920x1080_60.00 &

xset r rate 300 80
xset -b

eval $(ssh-agent)

udiskie &
copyq &
flameshot &
redshift &
unclutter &

exec i3
