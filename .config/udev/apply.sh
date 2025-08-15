#!/bin/sh
set -eu

rules_dir="${HOME}/.config/udev/rules.d"
dest_dir="/etc/udev/rules.d"

set -- "$rules_dir"/*.rules

if [ ! -e "$1" ]; then
    exit 0
fi

for f do
    sudo ln -sfn "$f" "$dest_dir/$(basename "$f")"
done

sudo udevadm control --reload
sudo udevadm trigger
