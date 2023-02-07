#!/bin/sh


# System xinit
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi


# Keyboard
setxkbmap gb
setxkbmap -option "caps:swapescape"


# Autostart
dex --autostart --wait
nitrogen --restore


# Window manager
exec dwm 2> /tmp/dwm.log

