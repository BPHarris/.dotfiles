# .dotfiles

My dotfiles.

## Install

### Prerequisites

**Core:**

```bash
# Minimal:
sudo pacman -S --needed git ttf-firacode-nerd ttf-font-awesome noto-fonts-emoji

# Recommended:
sudo pacman -S --needed git nerd-fonts ttf-font-awesome noto-fonts-emoji
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

Here are some interactive shell programs that are nicer and/or prettier than their coreutils counterparts:

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
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config --local status.showUntrackedFiles no
```

### Optional

**Bash completions (including the `config` alias):**

```bash
sudo ln -s $HOME/.config/bash-completion/completions/* /usr/share/bash-completion/completions/
```

This allows tab-completion when using the `config` git alias for managing this repo.

> [!CAUTION] Be sure to use `"$HOME"` in symbolic links!

## Additional First-Time Setup

### XDG User Dirs

I prefer `~/documents/` over `~/Documents/`, etc. and I don't like `desktop` and `publicshare` clogging up my home dir.
The follow script automates updating the XDG user dirs on first-time setup:

```bash
source $HOME/.local/bin/set-xdg-user-dirs
```

### Login Configuration

Todo:
Document auto-login in user shell profile on TTY1.
Fix keyring auto-unlock and document PAM settings.

### Enable user `systemd` units

Below are some `systemd` units that can’t be enabled by merely existing in the repo; they must be enabled manually.

```bash
systemctl --user daemon-reload

systemctl --user enable --now clamav-scan.timer

# Auto-start applications with dependencies when Hyprland launches
systemctl --user enable --now hyprland-session.target
systemctl --user enable --now keepassxc.service
systemctl --user enable --now nextcloud.service
```

**Verify ClamAV timer:**

```bash
systemctl --user list-timers --all
```

### Set `udev` Rules

There are some `udev` rules in `.config/udev/rules.d/*.rules` which must be symlinked to `/etc/udev/rules.d/*.rules` to take effect.
These are optional, and I only use them on my laptop.

These rules include:

- On switching to battery:
  set power profile to battery saving, set brightness to 50%, and disable Bluetooth if no devices are connected, set CPU governor to powersave;
- On switching to mains:
  set power profile to performance, set brightness to 100%, set CPU governor to performance.

These can be symlinked manually or by running the helper script:

```sh
.config/udev/apply.sh
```

Todo:
Should there be a `udev` rule to set the desktop CPU governor to performance?
Or should I leave this to be handled by `gamemode`?

### Theming

**Install GTK Theme:**

```bash
git clone https://github.com/vinceliuice/Orchis-theme.git /tmp/orchis-git
pushd /tmp/orchis-git
./install.sh --tweaks black --tweaks solid --tweaks compact --theme green --color dark --size compact --libadwaita --dest $HOME/.local/share/themes --name Orchis-Black
popd
rm -rf /tmp/orchis-git
```

**Install icon theme:**

```bash
yay -S luv-icon-theme-git
```

> [!CAUTION] Some icon themes will ruin GTK-4 app boot times (e.g. >1s for `ghostty`). Sometimes the manual install, repo, or AUR variant of a specific theme worked better (e.g. Tela from the AUR worked well but manually installed did not), sometimes it was always bad (e.g. Papirus).

**Additional:**

When `gsettings` is installed it takes priority over `$GTK_THEME` and `settings.ini`.
Therefore, we must set the `gsettings` variables correctly:

```bash
gsettings set org.gnome.desktop.interface gtk-theme $GTK_THEME
gsettings set org.gnome.desktop.interface icon-theme $ICON_THEME
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

**Qt Theme:**

This is handled via `QGtk3Style` (built into `qt5` and `qt6`), which tells Qt to follow the GTK theme.
This is enabled by `QT_QPA_PLATFORMTHEME=gtk3` set in `~/.config/hypr/hyprland.conf`.

**Flatpak:**

```bash
mkdir $HOME/.icons $HOME/.themes
sudo cp -r /path/to/themes/$GTK_THEME $HOME/.themes
sudo cp -r /path/to/icons/$ICON_THEME $HOME/.icons
```

This will need to be adjusted depending on where the theming you are using are installed.

Then we can expose these to flatpak:

```bash
sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.icons

sudo flatpak override --env=GTK_THEME=$GTK_THEME
sudo flatpak override --env=ICON_THEME=$ICON_THEME
```

> [!NOTE] We must do things this way as flatpak apps will only read theming from `~/.{themes,icons}` and not `~/.local/share/{themes,icons}` or `/usr/share/{themes,icons}`. And they will not follow symlinks by the seems.

**Todo:**

- Qt native:
  - Icons
- Qt flatpak:
  - QGtk3Style
  - Icons
- Helper script to check the theme automatically (there are a lot of places where variables need to be changed)

### Emoji Picker

**Dependencies:**

```bash
sudo pacman -S --needed wofi rofimoji wtype wl-clipboard
```

**Usage:**

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
However, for some features, manual intervention is required (see below).

**Markdown Formatting:**

For nice Markdown formatting, a custom install of `mdformat` is required, which in turn requires `pipx`.

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

Additionally, you must update the `mdformat` executable in `.config/nvim/lua/configs/conform.lua` to reference your user not `/home/anon/`.
Unfortunately, `$HOME` does not seem to work here.

The `conform.nvim` settings already use the above `mdformat` install.

## Sudo

Todo:
Basic superuser config and commands to set it up.
Such as a minimal `nvim` config and `.bashrc` with `ls` aliases, etc.

## Todo

- Redo `~/.local/bin/repeat` with `rich.progress` and various other improvements.
- Redo `vim` config.
  Either remove it entirely and only use `nvim`.
  Or, only use `nvim` (based) but keep a very minimal, nice `vim` config around.
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
  - I think the others should not be aliased; they should be used by choice.
- Add a full `pacman -S --needed ...` line for all dependencies.
- UFW?
  I have to redo this every install right now — a bit annoying.
- Plymouth?
  No need for any files, but include install/setup instructions in this doc.
- Arch install instructions?
  My install is far enough from vanilla to warrant some explanation here.
  Even if it’s just a description of the install that can then be given to ChatGPT as an interactive setup guide.
- Superuser configs (see above).
  Keep it very simple, but at least some `bash` config and some common-sense `nvim` settings are a must.
