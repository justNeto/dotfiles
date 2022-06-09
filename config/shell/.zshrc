#  __  __           _________  _   _ ____   ____
# |  \/  |_   _    |__  / ___|| | | |  _ \ / ___|
# | |\/| | | | |     / /\___ \| |_| | |_) | |
# | |  | | |_| |  _ / /_ ___) |  _  |  _ <| |___
# |_|  |_|\__, | (_)____|____/|_| |_|_| \_\\____|
#         |___/

export HOME="/home/neto"

# Prompt functionalities to be added
autoload -Uz add-zsh-hook
autoload -U colors && colors
setopt autocd
setopt interactive_comments
stty stop undef

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
PROMPT="%240F╭─${gray}   ( ${green}(${yellow}%n${green}) ${blue}| ${green}(${yellow}%~${green}) ${blue}| ${green}(${yellow}%1v${green})${gray} )"$'\n'"%240F╰─     ${reset} "
#PROMPT="%240F╭─${gray}   [%D{%L:%M:%S %p}] ( ${green}(${yellow}%n${green}) ${blue}| ${green}(${yellow}%~${green}) ${blue}| ${green}(${yellow}$(gitstat)${green})${gray} )"$'\n'"%240F╰─     ${reset} "

# Icons that could be used:
#          

TMOUT=1
TRAPALRM() {
	zle reset-prompt
}

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

# Bind keys
bindkey -v
export KEYTIMEOUT=1

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey -s '^f' 'lfrun\n'
bindkey -s '^s' 'lfrun $(fzf)\n'

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Load aliases and shortcuts if existent.
[ -f "$ZDOTDIR/shortcutrc" ] && source "$ZDOTDIR/shortcutrc"
[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"
[ -f "$ZDOTDIR/zshnameddirrc" ] && source "$ZDOTDIR/zshnameddirrc"

#Automatically do an ls after each cd
cd ()
{
	if [ -n "$1" ]; then
		clear
 		builtin cd "$@" && ls
 	else
		clear
 		builtin cd ~ && ls
 	fi
}
