# Change this if you need to change the vcxsrv install location
set -g XSRV_DIR "/mnt/h/Program Files/VcXsrv"

# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
set -g theme_display_cmd_duration no
set -g theme_display_date no

# Hook direnv
eval (direnv hook fish)
direnv allow

# Check if vcxsrv is running
set -g tasks (tasklist.exe /FI "IMAGENAME eq vcxsrv.exe" 2>NUL)
echo $tasks | findstr.exe /I /N "vcxsrv.exe">NUL
if test $status -ne 0; and test -e "$XSRV_DIR/xlaunch.exe"
	echo "X11 Server not found. Starting VcXsrv now..."
	eval "'$XSRV_DIR/vcxsrv.exe' -multiwindow 2>/dev/null &"
end
set -x DISPLAY :0

set -x NVM_DIR "~/.nvm"
if test -e "$NVM_DIR/nvm.sh":
  bash -c "$NVM_DIR/nvm.sh" # This loads nvm 
end
set PATH $PATH ~/.local/bin/ ~/gocode/bin ~/git-toolbelt
if test -e "$NVM_DIR/bash_completion":
	bash -c "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
end
