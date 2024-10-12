# .dotfiles

My dotfiles.



## Install

### Prerequisites

**Core:**
```bash
sudo pacman -S git ttf-firacode-nerd ttf-font-awesome terminus-font noto-fonts-emoji
```

**PulseAudio scripts:**
```bash
sudo pacman -S pamixer
```


### Required

```bash
git clone --bare https://github.com/bpharris/.dotfiles $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
```

Thereafter one may use `config` as though it were git, with tab-completeion!
(Provided you follow the related optional step).


### Optional

Nota Bene:
Be sure to use absolute paths in symblolic links to avoid any gotchas
(i.e. via `$HOME`).

**Mouse config:**
```bash
sudo ln -s $HOME/.config/X11/* /etc/X11/xorg.conf.d/
```

**Bash completions (including the `config` alias):**
```bash
sudo ln -s $HOME/.config/bash-completion/completions/* /usr/share/bash-completion/completions/
```

**Pacman hooks:**
```bash
# Update init ram fs on kernal and/or nvidia driver update:
sudo ln -s $HOME/.local/pacman-hooks/nvidia.hook /etc/pacman.d/hooks/nvidia.hook

# Reset user xkbmap on updating X11:
sudo ln -s $HOME/.local/pacman-hooks/xorg-set-user-xkbmap.hook /etc/pacman.d/hooks/xorg-set-user-xkbmap.hook
```


### Apply Theme to Flatpak

The easiest way is via
[flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal),
in the settings for `All Applications` expose the folders:

1. `~/.icons`
2. `~/.themes`

then set the GTK environment variables:

```sh
ICON_THEME=bpharris
GTK_THEME=bpharris
```

For more info see the
[itsfoss article](https://itsfoss.com/flatpak-app-apply-theme/).



## Extensions

Some optional additional configuration.


### Emoji Picker

For install instructions see: https://github.com/fdw/rofimoji

Note: `rofimoji` supports `wofi` by default, so this works for wayland also.

Use via:
```bash
# equivalent to `--action print type`
rofimoji

# print selected emoji to stdout
rofimoji -a print

# type the selected emoji for you
rofimoji -a type

# copy the selected emoji to the clipboard
rofimoji -a copy

# copy to the clipboard and print to stdout
rofimoji -a clipboard
rofimoji -a copy print

# lazy
rofimoji -a print copy type
```



## Unhandled Additions

Some related things I like to do that aren't covered yet.

* gtk / qt themes
* grub config
* plymouth config
* ufw config



## Todo

* refactor config files
* personal gtk/qt themes
* auto install script
* move to pipewire / pipewire-jack

