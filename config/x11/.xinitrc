#!/bin/sh

~/.fehbg &
remaps &
xcompmgr &
pulseaudio -k && pulseaudio --start &
sh ~/.screenlayout/Screen.sh &

export AWT_TOOLKIT=MToolkit

ssh-agent dwm
