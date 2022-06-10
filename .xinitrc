#!/bin/sh

xcompmgr &
xrdb .Xdefaults &
dwmbar &

remaps &
dunst &

rwp &
sh ~/.screenlayout/Screen.sh &
ssh-agent &

while true
do
	dwm
done
