#!/bin/bash

echo "Linking shortcuts..."
ln -sv "/mnt/c/Users/$USER/Documents" ~
ln -sv "/mnt/c/Users/$USER/Desktop" ~
#ln -sv "/mnt/c/Users/$USER/Pictures" ~
#ln -sv "/mnt/c/Users/$USER/Videos" ~
#ln -sv "/mnt/c/Users/$USER/Music" ~

echo "Checking for old backup files..."
if [[ ! -f ~/.profile_old  && ! -f ~/.bashrc_old && ! -f ~/.gitconfig]]; then
   echo "None found. Backing up existing files..."
   cp ~/.profile ~/.profile_old
   cp ~/.bashrc ~/.bashrc_old
   cp ~/.gitconfig ~/.gitconfig_old
else
   echo "Found existing backups. Will not overwrite them..."
fi

if [[ ! -d ~/wsl-dotfiles ]]; then
   mkdir ~/wsl-dotfiles
   cp -a . ~/wsl-dotfiles
   cd ~/wsl-dotfiles
   echo "Existing installation found. Using this instead."
   ./install.sh
   exit
fi
echo "Checking for updates..."
git pull

echo "Cleaning old files..."
rm -f ~/.profile ~/.bashrc ~/.gitconfig
echo "Linking new files..."
ln -sv "/home/$USER/wsl-dotfiles/.profile" ~
ln -sv "/home/$USER/wsl-dotfiles/.bashrc" ~
ln -sv "/home/$USER/wsl-dotfiles/.gitconfig" ~
echo "Finished!"
