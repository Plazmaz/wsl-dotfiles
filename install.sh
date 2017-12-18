#!/bin/bash
echo "Installing dependencies..."

if ! [ -x "$(command -v fish)" ]; then
    sudo add-apt-repository ppa:fish-shell/beta-2
    sudo apt-get update
    sudo apt-get install -y fish
    echo -e "\e[93m>>>\e[0m Installing oh-my-fish if not installed..."
fi

if [[ ! -d ~/.local/share/omf/ ]]; then
    curl -L "https://get.oh-my.fish" | fish
fi
echo -e "\e[93m>>>\e[0m Installing themes..."
fish -c "omf install bobthefish; omf theme bobthefish; exit"
echo -e "\e[93m>>>\e[0m Switching default shell..."
chsh -s `which fish`

sudo apt-get install -y git terminator xfce4

windir() {
    echo "/mnt/$1" | sed 's/\\/\//g' | sed 's/\b\(.\):/\L\1/g';
}

echo -e "\e[93m>>>\e[0m Installing fonts (This will take a while)..."
if [[ ! -d fonts ]]; then
    git clone https://github.com/powerline/fonts.git --depth=1
    powershell.exe -Command \&{"$(cat fonts/install.ps1)"}
    ./fonts/install.sh
fi
#powershell.exe -executionpolicy bypass -File fonts\\install.ps1

#echo -e "\e[93m>>>\e[0m Installing themes..."
#fish -c "omf install bobthefish; omf theme bobthefish; exit"

echo -e "\e[93m>>>\e[0m Linking shortcuts..."
# MY_DOCUMENTS=$(windir `powershell.exe -c "Write-Host ([Environment]::GetFolderPath('MyDocuments')) -NoNewLine"`)
# DESKTOP=$(windir `powershell.exe -c "Write-Host ([Environment]::GetFolderPath('Desktop')) -NoNewLine"`)
# ln -sv "$MY_DOCUMENTS" ~
# ln -sv "$DESKTOP" ~
#ln -sv "/mnt/c/Users/$USER/Pictures" ~
#ln -sv "/mnt/c/Users/$USER/Videos" ~
#ln -sv "/mnt/c/Users/$USER/Music" ~
ln -sv "$(windir)c" ~
ln -sv "$(windir)c/Users/Eddie" ~
ln -sv "$(windir)c/Users/Eddie/Dropbox" ~

echo -e "\e[93m>>>\e[0m Checking for old backup files..."
if [[ ! -f ~/.bash_aliases_old && ! -f ~/.profile_old  && ! -f ~/.bashrc_old && ! -f ~/.gitconfig_old && ! -f ~/.inputrc_old ]]; then
   echo "None found. Backing up existing files..."
   if [[ -f ~/.bash_aliases ]]; then
      cp ~/.bash_aliases ~/.bash_aliases_old
   fi
   if [[ -f ~/.inputrc ]]; then
      cp ~/.inputrc ~/.inputrc_old
   fi
   cp ~/.profile ~/.profile_old
   cp ~/.bashrc ~/.bashrc_old
   cp ~/.gitconfig ~/.gitconfig_old
else
   echo -e "\e[93m>>>\e[0m Found existing backups. Will not overwrite them..."
fi

echo -e "\e[93m>>>\e[0m Checking for updates..."
git pull

echo -e "\e[93m>>>\e[0m Updating..."
git stash
git pull
git stash pop

echo -e "\e[93m>>>\e[0m Cleaning unused files..."
rm -f ~/.profile ~/.bashrc ~/.gitconfig ~/.bash_aliases ~/.inputrc
echo -e "\e[93m>>>\e[0m Linking new files..."
ln -sv "$PWD/.profile" ~
ln -sv "$PWD/.bashrc" ~
ln -sv "$PWD/.inputrc" ~
ln -sv "$PWD/git/.gitconfig" ~
ln -sv "$PWD/.bash_aliases" ~

cp -rs "$PWD/.config" ~/
echo -e "\e[93m>>>\e[0m Finished!"
