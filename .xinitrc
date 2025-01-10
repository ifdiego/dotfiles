#!/bin/sh

[[ -e ~/.xprofile ]] && . ~/.xprofile

eval $(ssh-agent)

exec i3
