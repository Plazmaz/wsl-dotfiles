#!/bin/bash
echo "Installing dependencies..."
sudo apt-get install -y fish git terminator xfce4
script=$(curl -L "https://get.oh-my.fish")
fish -c "set -g ASSUME_YES; $script" 

echo "Switching default shell..."
chsh -s `which fish`

echo "Linking shortcuts..."
ln -sv "/mnt/c/Users/$USER/Documents" ~
ln -sv "/mnt/c/Users/$USER/Desktop" ~
#ln -sv "/mnt/c/Users/$USER/Pictures" ~
#ln -sv "/mnt/c/Users/$USER/Videos" ~
#ln -sv "/mnt/c/Users/$USER/Music" ~

echo "Checking for old backup files..."
if [[ ! -f ~/.bash_aliases_old && ! -f ~/.profile_old  && ! -f ~/.bashrc_old && ! -f ~/.gitconfig_old ]]; then
   echo "None found. Backing up existing files..."
   if [[ -f ~/.bash_aliases ]]; then
      cp ~/.bash_aliases ~/.bash_aliases_old
   fi
   cp ~/.profile ~/.profile_old
   cp ~/.bashrc ~/.bashrc_old
   cp ~/.gitconfig ~/.gitconfig_old
else
   echo "Found existing backups. Will not overwrite them..."
fi

LOC=$PWD
echo "Checking for updates..."
git pull

if [[ ! -d ~/wsl-dotfiles ]]; then
   mkdir ~/wsl-dotfiles
   cp -a . ~/wsl-dotfiles

else   
   cd ~/wsl-dotfiles
   echo "Existing installation found. Using that..."
fi

echo "Updating..."
git reset --hard origin/master
git pull

echo "Cleaning unused files..."
rm -f ~/.profile ~/.bashrc ~/.gitconfig ~/.bash_aliases
echo "Linking new files..."
ln -sv "/home/$USER/wsl-dotfiles/.profile" ~
ln -sv "/home/$USER/wsl-dotfiles/.bashrc" ~
ln -sv "/home/$USER/wsl-dotfiles/git/.gitconfig" ~
ln -sv "/home/$USER/wsl-dotfiles/.bash_aliases" ~
cp -rs "/home/$USER/wsl-dotfiles/.config" ~/.config
echo "Finished!"
