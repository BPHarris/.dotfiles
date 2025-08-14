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

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="zen"
export READER="zathura"
export PAGER="less"


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

if [ ! -d "$HOME/.local/desktop" ]; then
    mkdir -p "$HOME/.local/desktop"
fi
if [ ! -d "$HOME/.local/publicshare" ]; then
    mkdir -p "$HOME/.local/publicshare"
fi


#
# XDG base dirs
#

xdg-base-dirs

