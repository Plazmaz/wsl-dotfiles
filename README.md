# wsl-dotfiles
![A screenshot](https://i.imgur.com/42faUCK.png)
My dotfiles for Bash on Windows/Windows Subsytem for Linux
There are likely other projects with similar elements, but these are likely the most full-featured dotfiles for the windows subsystem for linux.

# The Stack
1. [tmux](https://github.com/tmux/tmux)
2. [tmuxinator](https://github.com/tmuxinator/tmuxinator), which is manages configs. You can access this via `tmuxinator daily`.
3. [Fish](https://github.com/fish-shell/fish-shell/), which is automagically set as the default shell.
4. [Oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) which is set to use bobthefish as the default theme.  
**This project requires powerline fonts to be installed on bash! It should prompt you to install them. If not, you can find them [here](https://github.com/powerline/fonts)**

# Installation

Run  
`./install.sh`  
And wait for installation to finish. If it didn't finish or something happened, please file an [issue](https://github.com/Plazmaz/wsl-dotfiles/issues).  
Once installation has finished, run `tmuxinator daily` to get started!  
To update these files, simply run `./install.sh` again to pull the latest changes from this repo.
