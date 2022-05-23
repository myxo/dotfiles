stty -ixon # disable ctrl-S and ctrl-Q in terminal
DISABLE_AUTO_UPDATE=true

EDITOR=nvim

fpath+=$HOME/.zsh/pure
export ZSH=$HOME/.oh-my-zsh

plugins=(
    compleat 
    colored-man-pages
    cp
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh


zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/myxo/.zshrc'
zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
zstyle ':completion:*' matcher-list ''
unsetopt AUTO_CD


autoload -U promptinit && promptinit
promptinit;

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
setopt share_history


bindkey '\e[3~' delete-char # del
bindkey ';5D' backward-word # ctrl+left 
bindkey ';5C' forward-word #ctrl+right
bindkey "^[[A"  history-beginning-search-backward
bindkey "^[[B"  history-beginning-search-forward

if [[ $EUID == 0 ]] 
then
    PURE_PROMPT_SYMBOL=%
fi
prompt pure

TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

alias ls='ls -h --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias grep='grep --colour=auto'
alias df='df -h'
alias du='du -h --max-depth=1 | sort -h'
alias piy='ping ya.ru'
alias ht='htop'
alias psg='ps aux | grep '
alias nd='nautilus --no-desktop'
alias ra='ranger'
alias gh='git hist'
alias gst='git status'
alias mk='make'
alias mkm='make -j8'
alias mkc='make clean'
alias mr='make run'
alias nv='nvim'
alias fm='vifm'

# Enable automatic rehash of commands 
_force_rehash() { 
    (( CURRENT == 1 )) && rehash 
        return 1   # Because we didn't really complete anything 
} 

unsetopt beep

export _JAVA_AWT_WM_NONREPARENTING=1

export PATH=$PATH:/home/myxo/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/scripts
export PATH=$PATH:$HOME/app/bin
export PATH=$PATH:/usr/local/go/bin


# script for extracting from different archives
ex () {
 if [ -f $1 ] ; then
   case $1 in
     *.tar.bz2) tar xvjf $1   ;;
     *.tar.gz)  tar xvzf $1   ;;
     *.tar.xz)  tar xvfJ $1   ;;
     *.bz2)     bunzip2 $1    ;;
     *.rar)     unrar x $1    ;;
     *.gz)      gunzip $1     ;;
     *.tar)     tar xvf $1    ;;
     *.tbz2)    tar xvjf $1   ;;
     *.tgz)     tar xvzf $1   ;;
     *.zip)     unzip $1      ;;
     *.Z)       uncompress $1 ;;
     *.7z)      7z x $1       ;;
     *)         echo "'$1' Не может быть распакован при помощи >ex<" ;;
   esac
 else
   echo "'$1' не является допустимым файлом"
 fi
}

setopt no_share_history
