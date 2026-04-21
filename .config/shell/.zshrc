export EDITOR=nvim
export NSFW_WALLPAPERS=nvim
export SFW_WALLPAPERS="$HOME/wallpapers/sfw"
export NSFW_WALLPAPERS="$HOME/wallpapers/nsfw"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export GOPATH="$HOME/go/"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/go/bin:/usr/local/go/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin::$HOME/.config/emacs/bin:/usr/sbin/python3.6:$HOME/.nix-profile/bin:$PYENV_ROOT/bin:$PATH"

alias ls="lsd --sort extension --group-dirs first --total-size --permission octal"
alias cd="z"
alias n="nvim"
alias ezrc="nvim $ZDOTDIR/.zshrc"
alias gs="git status"
alias ga="git add"
alias gA="git add -A"
alias gc="git commit"
alias gps="git push"
alias gpl="git pull"
alias gnb="git checkout -b"
alias gcb="git checkout"
alias gbu="git remote update origin --prune"
alias rmd="sudo rm -rf"
alias nvim-test='NVIM_APPNAME=nvim-harpoon-dev nvim'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# INFO: Zsh overrides for terminal shortcuts
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey '^t' clear-screen
bindkey -s '^f' 'tmux-sessionizer\n'
bindkey -s '^y' 'y\n'
bindkey -r '^l'

bindkey '^?' backward-delete-char # backspace key sequence
bindkey "^[[P" delete-char # delete key sequence

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

eval "$(pyenv init - zsh &)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
