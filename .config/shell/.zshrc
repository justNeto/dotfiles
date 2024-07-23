#  __  __           _________  _   _ ____   ____
# |  \/  |_   _    |__  / ___|| | | |  _ \ / ___|
# | |\/| | | | |     / /\___ \| |_| | |_) | |
# | |  | | |_| |  _ / /_ ___) |  _  |  _ <| |___
# |_|  |_|\__, | (_)____|____/|_| |_|_| \_\\____|
#         |___/
# Prompt functionalities to be added
#

(cat ~/.cache/wal/sequences &)

setopt autocd
setopt interactive_comments
stty stop undef

autoload -Uz add-zsh-hook
autoload -U colors && colors

# Colors for command prompt
red='%{'$(print -P '\e[38;5;196m')'%}'
reset='%{'$(print -P '\e[0m')'%}'
green='%{'$(print -P '\e[1;32m')'%}'
gray='%{'$(print -P '\e[1;37m')'%}'
yellow='%{'$(print -P '\e[1;33m')'%}'
blue='%{'$(print -P '\e[1;34m')'%}'
black='%{'$(print -P '\e[1;30m')'%}'
greenl='%{'$(print -P '\e[1;32;5m')'%}'

# Define custom psvar functions
gitscript() {
	psvar[1]=$(gitstat)
}

add-zsh-hook precmd gitscript

# In prompt a function to check last command status could be used and added to prompt, displaying the current status
PROMPT=$'\n'"%240F${gray} ╭─   ( ${green}(${yellow}%n${green}) ${blue}| ${green}(${yellow}%~${green}) ${blue}| ${green}(${yellow}%1v${green})${gray} )"$'\n'"%240F${gray} ╰─ ${reset}"

# Icons that could be used:
#           

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Bind keys : can check for a key sequence using <C-v>
bindkey -v
export KEYTIMEOUT=1
export TERM=xterm

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey '^?' backward-delete-char # backspace key sequence
bindkey "^[[P" delete-char # delete key sequence

bindkey -s '^f' 'lfrun\n'
bindkey -s '^s' 'lfrun $(fzf)\n'
bindkey -s '^p' 'youtube-playlists\n' # select a playlist to listen to
bindkey -s '^o' 'lfcd\n' # go to last dir

# Load aliases and shortcuts if existent.
[ -f "$ZDOTDIR/shortcutrc" ] && source "$ZDOTDIR/shortcutrc"
[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"

eval "$(zoxide init zsh)"
sleep 0.1 && clear
