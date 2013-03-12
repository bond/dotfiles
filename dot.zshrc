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

# BSD / Linux utf8 differencies (yes, it's annoying)
case $(uname -s) in
     *BSD)
     ;& # fallthrough

     Darwin)
     unicode="UTF-8"
     norwegian="no_NO"
     ;;

     *)
     unicode="utf8"
     norwegian="nb_NO"
     ;;
esac


# Locale
# english language
export LANG="en_US.$unicode"
export LC_CTYPE="$norwegian.$unicode"
# default sorting order
export LC_COLLATE="C"
# stuff I'm used to formatted in norwegian ways
export LC_NUMERIC="$norwegian.$unicode"
export LC_TIME="$norwegian.$unicode"
export LC_TELEPHONE="$norwegian.$unicode"

# Env
export PS1="%n %B%~%b> "
export RPS1="[%l@%m]"
export EDITOR="emacs"

export PATH="$PATH:/opt/local/bin:/var/lib/gems/1.9.1/bin/:$HOME/bin"

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
esac

# Local overrides
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
