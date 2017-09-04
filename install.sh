#!/bin/bash
echo "Installing dependencies..."
sudo apt-get install fish git

function windir() {
    echo $1 | sed -E 's+^/mnt/(.{1})+\1:+' | sed 's+:$+:/+1' 
}

echo -e "\e[93m>>>\e[0m Installing fonts (This will take a while)..."
git clone https://github.com/powerline/fonts.git --depth=1
powershell.exe -executionpolicy bypass -File install.ps1

echo "Installing oh-my-fish if not installed..."
if [[ -f "~/.local/share/omf/" ]]; then
	echo -e "$(curl -L "https://get.oh-my.fish") --noninteractive -y" | fish
fi

echo -e "\e[93m>>>\e[0m Installing themes..."
fish -c "omf install bobthefish; omf theme bobthefish; exit"

echo -e "\e[93m>>>\e[0m Linking shortcuts..."
$MY_DOCUMENTS = windir($(powershell.exe /c "[Environment]::GetFolderPath('MyDocuments')"))
ln -sv "/mnt/c/Users/$USER/Documents" ~
ln -sv "/mnt/c/Users/$USER/Desktop" ~
#ln -sv "/mnt/c/Users/$USER/Pictures" ~
#ln -sv "/mnt/c/Users/$USER/Videos" ~
#ln -sv "/mnt/c/Users/$USER/Music" ~

echo -e "\e[93m>>>\e[0m Checking for old backup files..."
if [[ ! -f ~/.bash_aliases_old && ! -f ~/.profile_old  && ! -f ~/.bashrc_old && ! -f ~/.gitconfig_old ]]; then
   echo "None found. Backing up existing files..."
   if [[ -f ~/.bash_aliases ]]; then
      cp ~/.bash_aliases ~/.bash_aliases_old
   fi
   cp ~/.profile ~/.profile_old
   cp ~/.bashrc ~/.bashrc_old
   cp ~/.gitconfig ~/.gitconfig_old
else
   echo -e "\e[93m>>>\e[0m Found existing backups. Will not overwrite them..."
fi

LOC=$PWD
echo -e "\e[93m>>>\e[0m Checking for updates..."
git pull

if [[ ! -d ~/wsl-dotfiles ]]; then
   mkdir ~/wsl-dotfiles
   cp -a . ~/wsl-dotfiles

else   
   cd ~/wsl-dotfiles
   echo -e "\e[93m>>>\e[0m Existing installation found. Using that..."
fi

echo -e "\e[93m>>>\e[0m Updating..."
git reset --hard origin/master
git pull

echo -e "\e[93m>>>\e[0m Cleaning unused files..."
rm -f ~/.profile ~/.bashrc ~/.gitconfig ~/.bash_aliases
echo -e "\e[93m>>>\e[0m Linking new files..."
ln -sv "/home/$USER/wsl-dotfiles/.profile" ~
ln -sv "/home/$USER/wsl-dotfiles/.bashrc" ~
ln -sv "/home/$USER/wsl-dotfiles/git/.gitconfig" ~
ln -sv "/home/$USER/wsl-dotfiles/.bash_aliases" ~
cp -rs "/home/$USER/wsl-dotfiles/.config" ~/.config
echo -e "\e[93m>>>\e[0m Finished!"
