#!/bin/bash

link () {
	mkdir -p -- "$2"
	ln --symbolic --force "$PWD"/"$1" "$2"
}

#link i3 $HOME/.config
#link compton.conf $HOME/.config
#link .spacemacs $HOME
link .gitconfig $HOME
#link .bashrc $HOME
link .bash_aliases $HOME
link nvim $HOME/.config
#link fish $HOME/.config
#link .zshrc $HOME
link settings.json $HOME/.config/VSCodium/User
link regolith/Xresources $HOME/.config/regolith
