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
export LC_ALL='en_GB.utf8'
export EDITOR="emacs"

export PATH="$PATH:/opt/local/bin:/var/lib/gems/1.9.1/bin/"

# Aliases
alias ll='ls -lA'
alias emacs='emacs -nw'

# Terminal specific
case $TERM in
  xterm*)
    precmd () {print -Pn "\e]0;%n@%m: %~\a"}
    ;;
esac

# OS Specific overrides
case $(uname -s) in
  Linux)
    alias ls='ls --color=auto'
    ;;
  Darwin)
    export LANG=en_GB.UTF-8
    export LC_ALL=$LANG
esac

# Local overrides
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
