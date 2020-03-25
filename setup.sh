#!/bin/bash
COMMAND="ln --symbolic --force"

$COMMAND $PWD/i3 $HOME/.config
$COMMAND $PWD/compton.conf $HOME/.config
$COMMAND $PWD/.spacemacs $HOME
$COMMAND $PWD/.gitconfig $HOME
