#!/bin/bash

#
#    _               _                           __ _ _
#   | |__   __ _ ___| |__       _ __  _ __ ___  / _(_) | ___
#   | '_ \ / _` / __| '_ \     | '_ \| '__/ _ \| |_| | |/ _ \
#  _| |_) | (_| \__ \ | | |    | |_) | | | (_) |  _| | |  __/
# (_)_.__/ \__,_|___/_| |_|____| .__/|_|  \___/|_| |_|_|\___|
#                        |_____|_|
# 
# Bash profile, runs on login.
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


[[ -f ~/.bashrc ]] && . ~/.bashrc

