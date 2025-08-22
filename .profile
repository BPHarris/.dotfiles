#!/bin/sh
# shellcheck disable=SC1091

# prepend_path DIR
prepend_path() {
	case ":$PATH:" in
	*:"$1":*) ;;
	*)
		export PATH="$1${PATH:+:$PATH}"
		;;
	esac
}

# append_path DIR
append_path() {
	case ":$PATH:" in
	*:"$1":*) ;;
	*)
		export PATH="${PATH:+$PATH:}$1"
		;;
	esac
}

export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='ghostty'
export BROWSER='zen-browser'
export READER='zathura'
export PAGER='less'

# Locale fallback
: "${LANG:=en_GB.UTF-8}"
export LANG

# Pagers used by many tools (git, man, etc.)
export LESS='-R'
export MANPAGER='less -R'

# Fix systemd pager warning
export SYSTEMD_PAGER=
export SYSTEMD_PAGERSECURE=1

# Ensure 24-bit colour when available
export COLORTERM='truecolor'

# User executables
prepend_path "$HOME/.local/bin"

# Prevent pipx from hijacking `.local/bin`
export PIPX_BIN_DIR="$HOME/.local/pipx/bin"
export PIPX_HOME="$HOME/.local/pipx/venvs"
append_path "$HOME/.local/pipx/bin"

# XDG base dirs
if [ -r "$HOME/.local/bin/xdg-base-dirs" ] && [ -f "$HOME/.local/bin/xdg-base-dirs" ]; then
	. "$HOME/.local/bin/xdg-base-dirs" || echo "xdg-base-dirs: non-zero exit" >&2
fi
