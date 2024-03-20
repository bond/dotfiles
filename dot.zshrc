# Lets have a long history but avoid dups
HISTSIZE=2000
HISTFILE=~/.zsh_history
SAVEHIST=2000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#
# Binds
bindkey "^[[A"  history-beginning-search-backward
bindkey "^[[B"  history-beginning-search-forward

# completition
autoload -Uz compinit promptinit vcs_info

zstyle ':completion:*' menu select _expand _complete
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true

# community completitions
# https://github.com/zsh-users/zsh-completions/tree/master
fpath=(~/.zsh/comp $fpath)

compinit
promptinit

# emacs style keybindings
bindkey -e

# Git prompt
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats ' • %b'

# This is specific to zsh but you could call $(git_prompt) in your .bashrc PS1 too.
setopt PROMPT_SUBST
                                                   
PROMPT='%B%F{blue}%~%F{yellow}${vcs_info_msg_0_}%f%(?.%F{green}.%F{red}) ➟ %b%f '

# BSD / Linux utf8 differencies (yes, it's annoying)
case $(uname -s) in
     *BSD)
     unicode="UTF-8"
     norwegian="no_NO"
     ;;

     Darwin)
     unicode="UTF-8"
     norwegian="no_NO"
     ;;

     *)
     alias ls='ls --color=auto'
     unicode="utf8"
     norwegian="nb_NO"
     ;;
esac


# Locale
# english language
#  - setup norwegian (ubuntu/debian: sudo locale-gen nb_NO.UTF-8)
export LANG="en_US.$unicode"
export LC_CTYPE="$norwegian.$unicode"
# default sorting order
export LC_COLLATE="C"
# stuff I'm used to formatted in norwegian ways
export LC_NUMERIC="$norwegian.$unicode"
export LC_TIME="$norwegian.$unicode"
export LC_TELEPHONE="$norwegian.$unicode"

# Useful env-variables (IN EXAMPLE for docker-compose)
export MY_UID=$(id -u)
export MY_GID=$(id -g)

export PATH="/usr/local/bin:/usr/local/sbin:$PATH:/opt/local/bin:$HOME/bin"

# Aliases
alias ls='ls --color=always'
alias ll='ls -lA'

# Git shortcuts
alias gd="git diff"
alias gc="git commit"
alias gp="git push"

# Terminal specific - set terminal titles
case $TERM in
  xterm*)
    precmd () {print -Pn "\e]0;%m: %~\a"}
    ;;
esac

# Local overrides
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

# rbenv
[ -f ~/.rbenv/bin/rbenv ] && eval "$(~/.rbenv/bin/rbenv init - zsh)"
