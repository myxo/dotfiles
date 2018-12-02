stty -ixon # disable ctrl-S and ctrl-Q in terminal

if [ $SSH_TTY ]; then
    EDITOR=vim
else
    EDITOR=vim
fi


export ZSH=$HOME/.oh-my-zsh
#ZSH_THEME="refined"

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
#    PROMPT=$'%{\e[1;31m%}%n %{\e[1;34m%}%~ #%{\e[0m%} ' # user dir %
    PURE_PROMPT_SYMBOL=%
else
#    PROMPT=$'%{\e[1;32m%}%n %{\e[1;34m%}%~ %#%{\e[0m%} ' # root dir #
    PURE_PROMPT_SYMBOL=\&
fi
#RPROMPT=$'%{\e[1;34m%}%T%{\e[0m%}' # right prompt with time
prompt pure

# Show if console is open from ranger
[ -n "$RANGER_LEVEL" ] && PS1='%F{yellow}(in ranger) '"$PS1"

TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

alias ls='ls -h --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias grep='grep --colour=auto'
alias df='df -h'
alias du='du -h --max-depth=1 | sort -h'
alias aupdate='sudo apt update'
alias aupgrade='sudo apt upgrade'
alias ainstall='sudo apt install '
alias asearch='apt search '
alias piy='ping ya.ru'
alias ht='htop'
alias psg='ps aux | grep '
alias nd='nautilus --no-desktop'
alias ra='ranger'
alias gh='git hist'
alias mk='make -j4'
alias mr='make -j4 run'

# Enable automatic rehash of commands 
_force_rehash() { 
    (( CURRENT == 1 )) && rehash 
        return 1   # Because we didn't really complete anything 
} 
zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete

unsetopt beep

export _JAVA_AWT_WM_NONREPARENTING=1

export PATH=$PATH:/home/myxo/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/scripts

export NUPIC=$HOME/build/nupic
export NUPIC_CORE=$HOME/build/nupic.core
export NO_AT_BRIDGE=1


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


# Run ranger with ability to return directory to zsh (do not actually use it)
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi  
    rm -f -- "$tempfile"
}


#ranger-cd will fire for Ctrl+O
bindkey -s '^O' 'ranger-cd\n'


