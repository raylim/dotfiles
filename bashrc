source ~/.bash_git
alias pd="pushd"
alias bd="popd"

export HISTIGNORE="&:ls:[bf]g:exit:bd:h:ll"

shopt -s extglob

umask 002
export EDITOR=vim
export PAGER=less
set -o vi
alias ls='ls -F --color=always'
alias ll='ls -l'
alias lt='ls -t'
alias h='history'
#alias rm='rm -i'
#alias cp='cp -i'
alias rsync='rsync --verbose --progress --stats --partial --recursive -a'
#alias vi="nvim"
#alias vi="vim --servername VIM"
alias sc="screen -RaAd"
alias colt="column -t -s$'\t'"
#alias colt="perl $HOME/usr/bin/display.pl"
alias lS="less -S"

source /etc/bash_completion.d/git
#export PS1='[\u@\h \W]\$ '
if [[ $- == *i* ]]; then
    export PS1="\[\033[38;5;1m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\w\[\e[1;35m\]\$(__git_ps1)\[\e[0;39m\]\n\[$(tput sgr0)\]\[\033[38;5;47m\]\A\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;226m\]\$?\[$(tput sgr0)\]\[\033[38;5;15m\]! \[$(tput sgr0)\]\[\033[38;5;21m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
    if [ "$TERM" == 'screen' ]; then
        export PS1=${PS1}'\[\033k\h\033\\\]'
    fi
fi

host=$(uname -n)
if [ "${TERM}" = "xterm" -o "${TERM}" = "xterm-color" -o "${TERM}" = "cygwin" -o "${TERM}" = "screen" -o "${TERM}" = "screen-256color" -o "${TERM}" = "xterm-256color" ]
then
    if [ -z "${BASH}" ]
    then
        echo "\033]2;${host}\007\033]1;${host}\007"
    else
        export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    fi
fi
if [ "$TERM" = "screen" ]; then
  screen_set_window_title () {
    ##local HPWD="$PWD"
    case $HPWD in
      $HOME) HPWD="~";;

                            #
      ### long name option:
      ## $HOME/*) HPWD="~${HPWD#$HOME}";;

      # short name option:
      *) HPWD=`basename "$HPWD"`;;
   esac
    printf '\ek%s\e\\' "$HPWD"
  }
  export PROMPT_COMMAND="screen_set_window_title; $PROMPT_COMMAND"
fi
function settitle() {
 if [ -n "$STY" ] ; then         # We are in a screen session
  echo "Setting screen titles to $@"
  printf "\033k%s\033\\" "$@"
  screen -X eval "at \\# title $@" "shelltitle $@"
 else
  printf "\033]0;%s\007" "$@"
 fi
}

ulimit -u 16384

alias tsvlook="csvlook -t"

# added by Anaconda3 4.4.0 installer
export PATH="/home/limr/anaconda3/bin:$PATH"
export PATH="/home/limr/usr/ActivePerl-5.24/bin:/home/limr/usr/ActivePerl-5.24/site/bin:$PATH"

