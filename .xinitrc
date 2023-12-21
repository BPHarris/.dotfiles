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


# Start dbus session (for seahorse)
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] ; then
	eval $(dbus-launch --exit-with-session --sh-syntax)
fi

dbus-update-activation-environment --verbose --all &> /tmp/xinit-start-dbus.log


# Autostart
dex --autostart --wait
nitrogen --restore


# Window manager
exec dwm 2> /tmp/dwm.log

