#!/bin/sh

#
#                     __ _ _
#    _ __  _ __ ___  / _(_) | ___
#   | '_ \| '__/ _ \| |_| | |/ _ \
#  _| |_) | | | (_) |  _| | |  __/
# (_) .__/|_|  \___/|_| |_|_|\___|
#   |_|
#
#
# Author: bpharris@pm.me
#


#
# Exports
#

export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="alacritty"
export BROWSER="brave"
export READER="zathura"


#
# Set TTY colours
#

source $HOME/.config/theme/colours/colours.sh


#
# Utils
#

append_path () {
	case ":$PATH:" in
		*:"$1":*)
			;;
		*)
			export PATH="${PATH:+$PATH:}$1"
	esac
}


#
# Add user executables to path
#

append_path "~/.local/bin"
append_path "~/.local/bin/scripts"

# Doom Emacs
append_path "~/.config/emacs/bin"

# Root bin
# Used by pipx etc
append_path "/root/.local/bin"


#
# XDG user dirs
#

# xdg-user-dirs-update expects that paths exist so create /tmp dirs
mkdir -p /tmp/desktop
mkdir -p /tmp/public


#
# XDG base dirs
#

xdg-base-dirs

