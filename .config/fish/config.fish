# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
set -g theme_display_cmd_duration no
set -g theme_display_date no
eval (direnv hook fish)
direnv allow
cmd.exe /c 'tasklist /FI "IMAGENAME eq vcxsrv.exe" 2>NUL | find /I /N "vcxsrv.exe">NUL'
if test $status -ne 0; and test -e "/mnt/c/Program Files/VcXsrv/xlaunch.exe"
	echo "X11 Server not found. Starting VcXsrv now..."
	cmd.exe /c "\"C:\Program Files\VcXsrv\vcxsrv.exe\" -multiwindow" &
end
set -x DISPLAY :0

export NVM_DIR="~/.nvm"
if test -e "$NVM_DIR/nvm.sh":
  . "$NVM_DIR/nvm.sh" # This loads nvm 
end
set PATH $PATH ~/.local/bin/ ~/gocode/bin ~/git-toolbelt
# PATH="$PATH:~/.local/bin/:/home/dylan/gocode/bin:~/git-toolbelt"
if test -e "$NVM_DIR/bash_completion":
	\. "$NVM_DIR/bash_completion"  # This loads nvm bash_completio
end
