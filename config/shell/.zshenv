#  __  __         _____    __     __
# |  \/  |_   _  | ____|_ _\ \   / /_ _ _ __ ___
# | |\/| | | | | |  _| | '_ \ \ / / _` | '__/ __|
# | |  | | |_| | | |___| | | \ V / (_| | |  \__ \
# |_|  |_|\__, | |_____|_| |_|\_/ \__,_|_|  |___/
#         |___/

export HOME="/home/neto"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="brave-browser-nightly"
export VIDEO="mpv"
export IMAGE="sxiv"
export WM="dwm"

# XDG DIRS
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_CONFIG_DIR="$HOME/.config"
export XDG_PICTURES_DIR="$HOME/Wallpapers"
export INPUTRC="$ZDOTDIR/inputrc"

# Some extra stuff
export GTK_THEME=Juno
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

# Locales and languages
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8 lf
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export RANGER_LOAD_DEFAULT_RC=false
export FEH_SKIP_MAGIC=1

# Config dirs
export GOPATH=$HOME/Go

# export PATH=$GOPATH/bin:$HOME/.local/bin/:/opt/resolve/bin/:$PATH
export PATH=$GOPATH/bin:$HOME/.local/pkgs/brave-1.34.x:$HOME/.local/bin/:/opt/resolve/bin/:$PATH
