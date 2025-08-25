#!/bin/bash
# shellcheck disable=SC1091

# Only apply to interactive shell
[[ $- != *i* ]] && return

# Prevent GPG passphrase prompts failing on TTY, tmux, etc
if GPG_TTY="$(tty 2>/dev/null)"; then
	export GPG_TTY
fi

# Set TTY colours
[[ -r "$HOME/.config/theme/colours/colours.sh" ]] && . "$HOME/.config/theme/colours/colours.sh"

# TODO
# source hostname specific config
# source ~/.config/host.d/$HOSTNAME

# Dotfiles
alias config='/usr/bin/git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME"'

# Shell options
shopt -s autocd
shopt -s histappend
shopt -s checkwinsize # Line wrap on window resize

# Unlimited bash history
export HISTCONTROL=ignoredups
export HISTFILESIZE=
export HISTSIZE=

# Flush to bash history immediately
case ";$PROMPT_COMMAND;" in
*';history -a;'*) ;;
*) PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac

# Do not allow > to override file, require >|
set -o noclobber

# Disable ^S/^Q nonsense
stty -ixon

# Functions
if command -v highlight &>/dev/null; then
	alias hl='highlight --stdout -O ansi'
fi

# Aliases (ls)
alias ls='ls -Xh --group-directories-first --color=auto'
alias lsize='ls -Alh --size'
alias la='ls -Ah'
alias ll='ls -lh'
alias lla='ls -Alh'

# Aliases (grep)
alias egrep='grep --color=auto -E'
alias fgrep='grep --color=auto -F'

# Aliases (colouring, misc.)
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Aliases (safety)
alias mv='mv -i'
alias rm='rm -I'
alias cp='cp -i'

# Emacs
if command -v emacs &>/dev/null; then
	alias emacs='emacsclient -c -a "emacs"'
fi

# Bash prompt
# See: https://man.archlinux.org/man/bash.1#PROMPTING
export PS1="\[\033[1;36m\]\w \[\033[32m\]\$\[\033[0m\] "
export PS2="\[\033[1;34m\]>\[\033[0m\] "
export PS3=""
export PS4="\[\033[1;34m\]+\[\033[0m\] "

# Man colouring
man() {
	LESS='--use-color -DSwGd -DP--' \
		GROFF_NO_SGR=1 \
		LESS_TERMCAP_md=$'\e[1;90m' \
		LESS_TERMCAP_me=$'\e[0m' \
		LESS_TERMCAP_us=$'\e[3;31m' \
		LESS_TERMCAP_ue=$'\e[0m' \
		LESS_TERMCAP_so=$'\e[1;4;32m' \
		LESS_TERMCAP_se=$'\e[0m' \
		command man "$@"
}

# Fun
alias starwars='telnet towel.blinkenlights.nl'
