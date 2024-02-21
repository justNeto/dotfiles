#  __  __       _____                 __ _ _
# |  \/  |_   _|__  /_ __  _ __ ___  / _(_) | ___
# | |\/| | | | | / /| '_ \| '__/ _ \| |_| | |/ _ \
# | |  | | |_| |/ /_| |_) | | | (_) |  _| | |  __/
# |_|  |_|\__, /____| .__/|_|  \___/|_| |_|_|\___|
#         |___/     |_|

export HOME="/home/neto"
export ZDOTDIR="$HOME/.config/shell"
source $ZDOTDIR/.zshenv

if [ -z "$SSH_AUTH_SOCK" ] ; then
	eval $(ssh-agent)
	ssh-add $HOME/.ssh/github-laptop
fi
