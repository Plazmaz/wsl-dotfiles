# wsl-dotfiles
![A screenshot](https://i.imgur.com/kEzmGzV.png)
My dotfiles for Bash on Windows/Windows Subsytem for Linux
There are likely other projects with similar elements, but these are likely the most full-featured dotfiles for the windows subsystem for linux.

# The Stack
The shell consists of four layers:
1. Vcxsrv, which will need to be downloaded seperately on the windows machine
2. [Terminator](https://launchpad.net/terminator), which is auto-installed, and can be run by using `terminator` in bash.
3. [Fish](https://github.com/fish-shell/fish-shell/), which is automagically set as the default shell.
4. [Oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) which is set to use bobthefish as the default theme.  
**This project requires powerline fonts to be installed on bash! You can find them [here](https://github.com/powerline/fonts)**

# Installation
Requirements: 
* https://github.com/powerline/fonts
* https://sourceforge.net/projects/vcxsrv/

Once you have installed these, run  
`./install.sh`  
And wait for installation to finish. If it didn't finish or something happened, please file an [issue](https://github.com/Plazmaz/wsl-dotfiles/issues).  
Once installation has finished, run `terminator` to get started!  
To update these files, simply run `./install.sh` again to pull the latest changes from this repo.
