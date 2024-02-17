#  __  __         _____    __     __
# |  \/  |_   _  | ____|_ _\ \   / /_ _ _ __ ___
# | |\/| | | | | |  _| | '_ \ \ / / _` | '__/ __|
# | |  | | |_| | | |___| | | \ V / (_| | |  \__ \
# |_|  |_|\__, | |_____|_| |_|\_/ \__,_|_|  |___/
#         |___/

export EDITOR="nvim"
export VISUAL="nvim"
export VIDEO="mpv"
export IMAGE="imv"

export XCURSOR_SIZE=24
export QT_QPA_PLATFORMTHEME="qt5ct"

# Environment for local binaries and others
export LOCAL_CONFIG_DIR="$HOME/.local"
export BIN_DIR="$LOCAL_CONFIG_DIR/bin"
export PKGS_DIR="$LOCAL_CONFIG_DIR/pkgs"
export SRC_DIR="$LOCAL_CONFIG_DIR/src" # personal compiled programs and files. Shoutout mr Luke Smith!

# XDG DIRS
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DOCUMENTS_DIR="$HOME/projects"
export XDG_VIDEOS_DIR="$HOME/vids"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_CONFIG_DIR="$HOME/.config"
export XDG_PICTURES_DIR="$LOCAL_CONFIG_DIR/wallpapers"
export XDG_SCREENSHOTS_DIR="$HOME/.screenshots"

# My personal wallpapers to be used with my bg script
export NSFW_WALLPAPERS="$LOCAL_CONFIG_DIR/wallpapers/NSFW_WALLPAPERS"
export SFW_WALLPAPERS="$LOCAL_CONFIG_DIR/wallpapers/SFW_WALLPAPERS"

# Locales and languages
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8 lf
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

# Variables to be added to path and also here for easier access
export GO_PATH=$HOME/.go
export CARGO_PATH=$HOME/.cargo

source $BIN_DIR/utils/update-path
export PATH="$PATH:$GO_PATH/bin/:$CARGO_PATH/bin/"
