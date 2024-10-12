#!/bin/bash


[[ -f ~/.profile ]] && . ~/.profile
[[ -f ~/.bashrc ]] && . ~/.bashrc


# Autostart Hyprland
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec Hyprland
fi

