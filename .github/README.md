# .dotfiles

My dotfiles.


## Install

### Prerequisites

```bash
# sudo pacman -S git ttf-firacode-nerd
```


### Required

```bash
$ git clone --bare https://github.com/bpharris/.dotfiles $HOME/.dotfiles
$ git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
```

Thereafter one may use `config` as though it were git, with tab-completeion!
(Provided you follow the related optional step).

### Optional

Nota Bene:
Be sure to use absolute paths in symblolic links to avoid any gotchas
(i.e. via `$HOME`).

Mouse config:

```bash
# ln -s $HOME/.config/X11/* /etc/X11/xorg.conf.d/
```

Bash completions (including the `config` alias):

```bash
# ln -s $HOME/.config/bash-completion/completions/* /usr/share/bash-completion/completions/
```


## Unhandled Additions

Some related things I like to do that aren't covered by dots.

* gtk / qt Themes
* grub config
* plymouth config
* ufw config


## Todo

* refactor config files
* personal gtk/qt themes
* auto install script

