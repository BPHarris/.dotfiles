#!/bin/bash

EMPTY_WAYBAR_OUTPUT='{"text": "", "class": "hidden"}'

MOUSE_BATTERY_ID="hid.*battery"
MOUSE_PATHS=$(upower -e | grep -i "$MOUSE_BATTERY_ID")

if [ -z "$MOUSE_PATHS" ]; then
	echo "$EMPTY_WAYBAR_OUTPUT"
	exit 0
fi

is_g703() {
	local device_info
	local model

	device_info=$(upower -i "$1")
	model=$(echo "$device_info" | grep "model" | awk -F': ' '{print tolower($2)}')

	case "$model" in
	*"g703"*)
		return 0
		;;
	*)
		return 1
		;;
	esac
}

G703_PATH=""
while IFS= read -r path; do
	if is_g703 "$path"; then
		G703_PATH="$path"
		break
	fi
done <<<"$MOUSE_PATHS"

if [ -z "$G703_PATH" ]; then
	echo "$EMPTY_WAYBAR_OUTPUT"
	exit 0
fi

BATTERY_INFO=$(upower -i "$G703_PATH")
PERCENTAGE=$(echo "$BATTERY_INFO" | grep "percentage" | awk '{print $2}' | tr -d '%')
CHARGING=$(echo "$BATTERY_INFO" | grep "state" | awk '{print $2}')

get_battery_icon() {
	if [ "$1" -ge 40 ]; then
		echo "󰁹"
	elif [ "$1" -ge 20 ]; then
		echo "󰂎"
	else
		echo "󰂃"
	fi
}

MOUSE_ICON="󰍽"
CHARGING_ICON="󰚥"
BATTERY_ICON=$(get_battery_icon "$PERCENTAGE")

if [ "$CHARGING" = "charging" ]; then
	echo "{\"text\": \"$MOUSE_ICON $CHARGING_ICON\", \"class\": \"charging\"}"
else
	if [ "$PERCENTAGE" -le 20 ]; then
		CLASS="battery-low"
	else
		CLASS="battery"
	fi
	PADDED_PERCENTAGE=$(printf "% 3d%%" "$PERCENTAGE")
	echo "{\"text\": \"$MOUSE_ICON $PADDED_PERCENTAGE $BATTERY_ICON\", \"class\": \"$CLASS\"}"
fi
