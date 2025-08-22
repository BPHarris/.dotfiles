#!/bin/bash
# shellcheck disable=SC1091

[[ -f "$HOME/.profile" ]] && . "$HOME/.profile"
[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"

# Auto-start Hyprland
if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" && "${XDG_VTNR:-0}" -eq 1 ]] &&
	command -v Hyprland >/dev/null 2>&1; then
	exec Hyprland
fi
