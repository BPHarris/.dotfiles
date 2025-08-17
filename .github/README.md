# .dotfiles

My dotfiles.

## Install

### Prerequisites

**Core:**

```bash
# Minimal:
sudo pacman -S --needed git ttf-firacode-nerd ttf-font-awesome terminus-font noto-fonts-emoji

# Recommended:
sudo pacman -S --needed git nerd-fonts ttf-font-awesome terminus-font noto-fonts-emoji
```

**Desktop Environment:**

```bash
sudo pacman -S --needed hyprland hypridle hyprpaper hyprlock xdg-desktop-portal-hyprland polkit-kde-agent wpctl playerctl brightnessctl bluez blueman networkmanager
yay -S --needed ags-hyprpanel-git

sudo pacman -S --needed alacritty ghostty keepassxc nextcloud-client htop btop tmux
```

**Screenshots:**

```bash
sudo pacman -S --needed grim swappy
yay -S --needed grimblast-git
```

**Optional:**

Here are some interactive shell programs that are nicer and/or prettier than their coreutils, etc counterparts:

```bash
sudo pacman -S --needed eza lsd bat ripgrep duf dysk dust fd trash-cli sd gping git-delta xh
```

| Program     | Improves | Notes                                  |
| :---------- | :------- | :------------------------------------- |
| `eza`       | `ls`     |                                        |
| `lsd`       | `ls`     |                                        |
| `bat`       | `cat`    |                                        |
| `rg`        | `grep`   | Package name is `ripgrep`.             |
| `duf`       | `df`     |                                        |
| `dysk`      | `df`     |                                        |
| `dust`      | `du`     |                                        |
| `fd`        | `find`   |                                        |
| `trash-cli` | `rm`     | Uses rubbish bin rather than deleting. |
| `sd`        | `sed`    |                                        |
| `gping`     | `ping`   |                                        |
| `git-delta` | `diff`   | Package name is `git-delta`.           |
| `xh`        | `curl`   |                                        |

### How to Install

```bash
git clone --bare https://github.com/bpharris/.dotfiles $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
```

### Optional

**Bash completions (including the `config` alias):**

```bash
sudo ln -s $HOME/.config/bash-completion/completions/* /usr/share/bash-completion/completions/
```

This will allow for tab-completion when using the `config` git alias for managing this repo.

> [!CAUTION] Be sure to use `"$HOME"` in symbolic links!

## Additional First Time Setup

### Set `udev` Rules

There are some `udev` rules in `.config/udev/rules.d/*.rules` which must be symlinked to `/etc/udev/rules.d/*.rules` to take effect.
These are optional and I only use them on my laptop.

These rules include:

- On switching to battery:
  set power profile to battery saving, set brightness to 50%, and disable Bluetooth if no devices are connected;
- On switching to mains:
  set power profile to performance, set brightness to 100%.

These can be symlinked manually or by running the helper script:

```sh
.config/udev/apply.sh
```

Todo:
Should there be a `udev1` rule to set desktop CPU governor to performance?
Or should I leave this to be handled by `gamemode`?

### Theming

**GTK Theme:**

```bash
git clone https://github.com/vinceliuice/Orchis-theme.git /tmp/orchis-git
pushd /tmp/orchis-git
./install.sh --tweaks black --tweaks solid --tweaks compact --theme green --size compact --libadwaita
popd
rm -rf /tmp/orchis-git
```

**Icon Theme:**

```bash
git clone https://github.com/vinceliuice/Tela-icon-theme.git /tmp/tela-git
pushd /tmp/tela-git
./install.sh -c green
popd
rm -rf /tmp/tela-git

# GTK does not respect ICON_THEME and settings.ini did not seem to work by itself
gsettings set org.gnome.desktop.interface icon-theme Tela-green-dark
```

**Qt Theme:**

This is handled via `QGtk3Style` (built in to `qt5` and `qt6`) which tells Qt to follow the GTK theme.
This is enabled by `QT_QPA_PLATFORMTHEME=gtk3` set in `~/.config/hypr/hyprland.conf`.

**Flatpak:**

The easiest way is via [flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal), in the settings for `All Applications` expose the folders:

1. `~/.local/share/icons/`
1. `~/.local/share/themes/`

Then set the environment variables:

```sh
QT_QPA_PLATFORMTHEME=gtk3
ICON_THEME=Orchis-Green-Dark-Compact
GTK_THEME=Tela-green-dark
```

**Todo:**

- Are Qt icons set correctly?
- Helper script to check theme automatically (there are a lot of places that variables need to be changed).
  - Can the Flatpak theming be automated?

### Emoji Picker

**Dependencies:**

```bash
sudo pacman -S --needed wofi rofimoji wtype wl-clipboard
```

**Use via:**

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

### Neovim

The dotfiles should cover the basic install (though a `:MasonInstallAll` with possible manual plug-in selection is required).
However, for some features manual intervention will be required, see below.

**Markdown Formatting:**

For nice markdown formatting a custom install of `mdformat` is required in turn requiring `pipx`.

```bash
# Install `pipx`
sudo pacman -S python-pipx
pipx ensurepath

# Install mdformat with mdformat-tables
pipx install mdformat
pipx inject mdformat mdformat-tables

# Double check it worked
mdformat --help | grep tables
```

The `conform.nvim` settings already use the above `mdformat` install.

## Sudo

Todo:
basic super user config and commands to set it up.
Such as a minimal `nvim` config and `.bashrc` with `ls` aliases, etc.

## Todo

- Migrate to new theming on desktop:
  - Move `waybar` mouse battery script to `hyprpanel`.
  - Remove `~/.config/waybar/`.
  - Remove `~/.config/wlogout/`.
- Move to `ghostty`.
- Move to `fuzzel` over `wofi`.
  - This will require either a `rofimoji` change or a new emoji picker.
- New convenience aliases if "improved" utils are installed:
  - `eza` instead of `ls`
    - `la`, `lla`, `ltree`, etc. with icons enabled
  - I think the others should not be aliased, they should be used by choice.
- Add a full `pacman -S --needed ...` line for all dependencies.
- UFW?
  I have to redo this every install right now, bit annoying.
- Plymouth?
  No need for any files, but include install/setup instructions in this doc.
- Arch install instructions?
  My install is far enough from vanilla to warrant some explanation here.
  Even if it is just a description of the install that can then be given to ChatGPT as an interactive setup guide.
- Super user configs, see above.
  Keep it very simple, but at least some `bash` config and some common sense `nvim` settings are a must.
