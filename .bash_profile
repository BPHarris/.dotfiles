#!/bin/bash

[[ -f "$HOME"/.profile ]] && . "$HOME"/.profile
[[ -f "$HOME"/.bashrc ]] && . "$HOME"/.bashrc

# Created by `pipx`
export PATH="$PATH:/home/anon/.local/pipx/bin"

# Autostart Hyprland
if [ "$DISPLAY" = "" ] && [ "$WAYLAND_DISPLAY" = "" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec Hyprland
fi
