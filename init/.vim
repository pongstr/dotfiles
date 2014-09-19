#!/usr/bin/env bash

DOT="$HOME/.dotfiles"

echo "Linking Vim run commands"
cp -RfXv "$DOT/editors/colors/Pongstr Base-16.vim" "$HOME/.vim/colors/Pongstr Base-16.vim"
cp -RfXv "$DOT/editors/config/.vimrc" "$HOME/.vimrc"

if [ ! -d "$HOME/.vim" ]; then
  echo "Adding vim directory and sub-directories for backups, colors, swaps and undo"
  mkdir -p $HOME/.vim
  mkdir -p $HOME/.vim/.vminfo
  mkdir -p $HOME/.vim/backups
  mkdir -p $HOME/.vim/colors
  mkdir -p $HOME/.vim/swaps
  mkdir -p $HOME/.vim/undo
else
  echo "Adding vim sub-directories for backups, colors, swaps and undo"
  mkdir -p $HOME/.vim/.vminfo
  mkdir -p $HOME/.vim/backups
  mkdir -p $HOME/.vim/colors
  mkdir -p $HOME/.vim/swaps
  mkdir -p $HOME/.vim/undo
fi
