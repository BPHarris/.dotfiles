#!/bin/bash


# Only apply to interactive shell
[[ $- != *i* ]] && return


# Dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
config config --local status.showUntrackedFiles no


# XDG base dirs
source xdg-base-dirs


#
# Shell options
#

shopt -s autocd

export HISTCONTROL=ignoredups
shopt -s histappend

# Unlimited bash history
export HISTFILESIZE=
export HISTSIZE=

# Flush to bash history immediately
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Line wrap on window resize
shopt -s checkwinsize

# Do not allow > to override file, require >|
set -o noclobber

# Disable ^S/^Q nonsense
stty -ixon


#
# Functions
#

# Highlight
if command -v highlight &> /dev/null ; then
	alias hl="highlight --stdout -O ansi"
fi


#
# ANSI / terminfo escape sequences
#

BLACK="\[$(tput setaf 0)\]"
RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
BLUE="\[$(tput setaf 4)\]"
PURPLE="\[$(tput setaf 5)\]"
CYAN="\[$(tput setaf 6)\]"
WHITE="\[$(tput setaf 7)\]"

BLACK_BG="\[$(tput setab 0)\]"
RED_BG="\[$(tput setab 1)\]"
GREEN_BG="\[$(tput setab 2)\]"
YELLOW_BG="\[$(tput setab 3)\]"
BLUE_BG="\[$(tput setab 4)\]"
PURPLE_BG="\[$(tput setab 5)\]"
CYAN_BG="\[$(tput setab 6)\]"
WHITE_BG="\[$(tput setab 7)\]"

BLINK="\[$(tput blink)\]"
BOLD="\[$(tput bold)\]"
DIM="\[$(tput dim)\]"
REVERSE="\[$(tput rev)\]"
ITALIC_ON="\[$(tput sitm)\]"
ITALIC_OFF="\[$(tput ritm)\]"
HIGHLIGHT_ON="\[$(tput smso)\]"
HIGHLIGHT_OFF="\[$(tput rmso)\]"
UNDERLINE_ON="\[$(tput smul)\]"
UNDERLINE_OFF="\[$(tput rmul)\]"

RESET="\[$(tput sgr0)\]"


#
# Colour program output
#

alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias ip="ip --color=auto"

export LESS="-R --use-color"

export MANPAGER="less -R --use-color -Dd+r -Du+b"

man() {
	# md - program name and heading names
	# me - seemingly random (often includes options in usage section)
	# so - status line
	# se - seemingly random
	# us - options, arguments, file system paths
	# ue - seemingly random
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;35m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	command man "$@"
}


#
# Aliases
#

if command -v lsd &> /dev/null ; then
	alias ls="lsd --group-dirs=first"
	alias lsize="ls -Alh --total-size"
	alias ltree="ls --tree"
else
	alias ls="ls -Xh --group-directories-first --color=auto"
	alias lsize="ls -Alh --size"
fi

alias la="ls -Ah"
alias ll="ls -lh"
alias lla="ls -Alh"

alias egrep="grep -E"
alias fgrep="grep -F"

# Saftey
alias mv="mv -i"
alias rm="rm -I"
alias cp="cp -i"

# Emacs
if command -v emacs &> /dev/null ; then
	alias emacs="emacsclient -c -a 'emacs'"
fi

# MPV
# Distinguish between mpv from terminal and other (xdg-open, etc)
#	terminal:	WM_CLASS(STRING) = "swallow-mpv", "mpv"
#	other:		WM_CLASS(STRING) = "gl", "mpv"
alias mpv="mpv --x11-name='swallow-mpv'"


#
# Bash prompt
# See: ANSI / terminfo above
# See: https://man.archlinux.org/man/bash.1#PROMPTING
#

export PS1="${BOLD}${RED}\w ${GREEN}\$${RESET} "
export PS2="${BOLD}${BLUE}>${RESET} "
export PS3=""
export PS4="${BOLD}${BLUE}+${RESET} "


#
# Fun
#

alias starwars="telnet towel.blinkenlights.nl"

