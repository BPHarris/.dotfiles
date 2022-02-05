# .dotfiles

My personal linux dotfiles, primarity oriented around Arch and DWM/Qtile/Awesome/Gnome.
Also used on Pop\_OS and Fedora.


## Configs Included

- [x] .bash* and .profile
- [x] xdg-base-dirs
	* npm, python, etc
- [x] vim
- [ ] nvim
- [ ] gvim/ gnvim
- [x] alacritty
- [x] picom


## Install

```bash
$ git clone --bare https://github.com/bpharris/.dotfiles $HOME/.dotfiles
$ config checkout
```


## Unhandled Additions

Some related things I like to do that aren't covered by dots.

### GTK / Qt Themes

My GTK theme of choice varies with distro and WM / DE:

Distro | WM / DE    | GTK 4 Theme  | GTK 2/3 Theme | Qt Theme
:------|:-----------|:-------------|:--------------|:---------------
Arch   | Gnome      | Default dark | adw-gtk3-dark | QGnomePlatform
Arch   | Any tiling | TBD          | TBD           | TBD
Pop_OS | Gnome      | Default dark | Default dark  | Default dark
Fedora | Gnome      | Default dark | adw-gtk2-dark | QGnomePlatform

In all cases I tend to use Papirus or Tela icons, with the exception of Pop_OS! for
which I keep everything default.

For tiling window managers I mostly use CLI and TUI programs and as such I am less
conserned with the theme, default dark is what I currently use.

### GRUB Theme

https://github.com/vinceliuice/grub2-themes

### Plymouth

https://wiki.archlinux.org/title/Plymouth

### UFW

https://wiki.archlinux.org/title/Uncomplicated_Firewall


## Todo

* vimrc do not auto complete [ in markdown
* neovim config
* graphic vim/neovim config

* personal grub theme repo

* WM/DE rices:
	* Qtile rice
	* Redo suckless/dwm rice but more gooderer
	* Awesome rice

* Auto install script

