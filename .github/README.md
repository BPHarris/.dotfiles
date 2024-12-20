# .dotfiles

My dotfiles.

## Install

### Prerequisites

**Core:**

```bash
sudo pacman -S git ttf-firacode-nerd ttf-font-awesome terminus-font noto-fonts-emoji
```

The complete Nerd Fonts package should be installed for maximum compatibility.

**PulseAudio scripts (.local/bin/xf86-pulseaudio, etc.):**

```bash
sudo pacman -S pamixer
```

### Required

```bash
git clone --bare https://github.com/bpharris/.dotfiles $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
```

Thereafter one may use `config` as though it were git, with tab-completion!
(Provided you follow the related optional step).

### Optional

Nota Bene:
Be sure to use absolute paths in symbolic links to avoid any gotchas (i.e. via
`$HOME`).

**Bash completions (including the `config` alias):**

```bash
sudo ln -s $HOME/.config/bash-completion/completions/* /usr/share/bash-completion/completions/
```

### Apply Theme to Flatpak

The easiest way is via
[flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal), in the
settings for `All Applications` expose the folders:

1. `~/.icons`
1. `~/.themes`

Then set the GTK environment variables:

```sh
ICON_THEME=bpharris
GTK_THEME=bpharris
```

For more info see the
[itsfoss article](https://itsfoss.com/flatpak-app-apply-theme/).

## Extensions

Some optional additional configuration.

### Emoji Picker

The `rofimoji` package can be installed via `pacman`, however, I had issues with
this version and as such the `.local/bin/rofimoji` has been added to run
`rofimoji` from `pip` (installed via `pip install rofimoji`).

Note:
`rofimoji` supports `wofi` by default, so this works for Wayland also.

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

## Todo

- new gtk/qt theme - use existing?
  See ml4w

- tmux?
  Nice for nvim + terminal sessions?

- move to pipewire / pipewire-jack

- ufw config

- plymouth config

- grub config - don't display a load of rubbish
