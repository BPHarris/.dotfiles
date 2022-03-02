# .dotfiles

My personal dotfiles for Arch Linux with Awesome window manager and alacritty terminal.


## Prerequisites

* Bash (Zsh, etc not currently supported)
* A display manager set to boot your chosen DE/WM (or add an `.xinitrc`)

### [Optional] Plymouth Theme

Plymouth should be installed and configured as per https://wiki.archlinux.org/title/Plymouth#Installation.

I used the following configuration, `/etc/plymouth/plymouthd.conf`:

```
[Daemon]
Theme=spinner
ShowDelay=0
DeviceTimeout=8

```

### [Optional] LightDM

Install and configure as per https://wiki.archlinux.org/title/LightDM#Installation. I use the https://archlinux.org/packages/?name=lightdm-webkit-theme-litarvan.


## Install

```bash
$ git clone --bare https://github.com/BPHarris/.dotfiles $HOME/.cfg
$ config checkout
```


## Dependencies

### GTK Theme

The GTK theme Numix is used and can be installed via the AUR (https://aur.archlinux.org/packages/numix-gtk-theme) or manually and placed in `/usr/share/themes/`.

Alternatively, the GTK theme can be changed:

* change `gtk-theme-name` in `.config/gtk-3.0/settings.ini`


### Qt Theme

Todo: numix

### Icon Theme

The icon theme used is `Tela-green-dark` (in `Tela-green.tar.xz` in https://www.pling.com/p/1279924/) this must be manually installed to `/usr/share/icons/`, or changed in the following places:

* change `gtk-icon-theme-name` in `.config/gtk-3.0/settings.ini`

### Fonts

Todo: nerd fonts install steps


## Todo

* Numix fork with appropriate colours
	- [ ] GTK
	- [ ] Qt
* vimrc do not auto complete [ in markdown
* neovim config
* graphic neovim config
* WM/DE rice:
	* Awesome rice
		- [ ] Bar
		- [ ] Centre floating windows on spawn
		- [ ] Task list
		- [ ] Add window decorations iff window is floating
		- [ ] Icon theme
	* Qtile rice
	* XFCE rice
	* Gnome rice
* Auto install script


* Awesome / Qtile with an XFCE base

