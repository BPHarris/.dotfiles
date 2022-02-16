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
export BROWSER="librewolf"
export READER="zathura"


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

append_path ~/.local/bin
append_path ~/.local/bin/scripts


#
# XDG base dirs
#

xdg-base-dirs


#
# X session
#

USERXSESSION="$XDG_CACHE_HOME/X11/xsession"
USERXSESSIONRC="$XDG_CACHE_HOME/X11/xsessionrc"
ALTUSERXSESSION="$XDG_CACHE_HOME/X11/Xsession"
ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"


#
# Vim / Neovim / Gvim
#

export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.vim" | so $MYVIMRC'

