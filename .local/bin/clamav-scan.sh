#!/bin/sh
set -eu

HOME="/home/anon"

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/clamav"
mkdir -p "$STATE_DIR"

LOG="${STATE_DIR}/clamdscan.log"

# Ensure prerequisites
if ! command -v clamdscan >/dev/null 2>&1; then
	printf '%s\n' "clamdscan not found in PATH."
	exit 127
fi

if ! systemctl is-active --quiet clamav-daemon.service; then
	printf '%s\n' "clamav-daemon.service is not running (start with: sudo systemctl enable --now clamav-daemon.service)"
	exit 2
fi

# Subcommands
case "${1-}" in
--list)
	if [ -s "$LOG" ]; then
		grep 'FOUND$' -- "$LOG" | sed 's/: .*FOUND$//'
	else
		printf '%s\n' "No log at $LOG"
	fi
	exit 0
	;;
--help | -h)
	base="$(basename "$0")"
	printf '%s\n' "Usage: $base [SCAN_DIR] (defaults to $HOME)"
	printf '%s\n' "       $base --list"
	exit 0
	;;
esac

SCAN_DIR="${1:-$HOME}"

clamdscan --reload >/dev/null 2>&1 || :
clamdscan \
	--infected \
	--multiscan \
	--quiet \
	--stdout \
	--fdpass \
	--log="$LOG" \
	"$SCAN_DIR" 2>>"${LOG}.warn" || :

infect_count=0
if [ -s "$LOG" ]; then
	infect_count="$(awk '/FOUND$/ {c++} END {print c+0}' "$LOG" 2>/dev/null)"
fi

if command -v notify-send >/dev/null 2>&1; then
	if [ "$infect_count" -gt 0 ]; then
		printf '\a'
		msg="$(printf '%s\n%s' "$infect_count infections detected." "Check $LOG.")"
		notify-send --urgency=critical --icon=dialog-warning "ClamAV" "$msg"
	else
		notify-send --urgency=low --icon=dialog-information "ClamAV" "No infections found."
	fi
fi

if [ "$infect_count" -gt 0 ]; then
	printf '%s\n' "Detected $infect_count infected file(s)"
	printf '%s\n' "See: $LOG"
else
	printf '%s\n' "No infections found"
fi
