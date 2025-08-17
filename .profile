#!/bin/sh

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

. "$HOME"/.config/theme/colours/colours.sh

#
# Utils
#

append_path() {
    case ":$PATH:" in
    *:"$1":*) ;;
    *)
        export PATH="${PATH:+$PATH:}$1"
        ;;
    esac
}

#
# Add user executables to path
#

append_path "$HOME/.local/bin"
append_path "$HOME/.local/bin/scripts"
append_path "$HOME/.local/scripts"

# Doom Emacs
append_path "$HOME/.config/emacs/bin"

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
