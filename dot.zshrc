#
# Binds
bindkey "^[[A"  history-beginning-search-backward
bindkey "^[[B"  history-beginning-search-forward

zstyle ':completion:*' completer _expand _complete
zstyle :compinstall filename "~/.zshrc"

autoload -Uz compinit
compinit
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e


# Env
export PS1="%n %B%~%b> "
export RPS1="[%l@%m]"

export LANG='en_US.UTF-8'
export EDITOR="vim"

# Aliases
alias ll='ls -lA'

# Terminal specific
case $TERM in
  xterm*)
    precmd () {print -Pn "\e]0;%n@%m: %~\a"}
    ;;
esac
