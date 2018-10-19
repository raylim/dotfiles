source ~/.git-prompt.sh
alias pd="pushd"
alias bd="popd"

export HISTIGNORE="&:ls:[bf]g:exit:bd:h:ll"

shopt -s extglob

umask 002
export EDITOR=nvim
export PAGER=less
set -o vi
alias ls='ls -FG'
alias ll='ls -l'
alias lt='ls -t'
alias h='history'
#alias rm='rm -i'
#alias cp='cp -i'
alias rsync='rsync --verbose --progress --stats --partial --recursive -a'
alias vi="nvim"
#alias vi="vim --servername VIM"
alias sc="screen -RaAd"
alias colt="column -t -s$'\t'"
alias lS="less -S"
alias qstat="qstat -u 'limr'"
alias tsvlook="csvlook -t"

#source /etc/bash_completion.d/git
#export PS1='[\u@\h \W]\$ '
if [[ $- == *i* ]]; then
    export PS1="\[\033[38;5;1m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\w\[\e[1;35m\]\$(__git_ps1)\[\e[0;39m\]\n\[$(tput sgr0)\]\[\033[38;5;47m\]\A\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;226m\]\$?\[$(tput sgr0)\]\[\033[38;5;15m\]! \[$(tput sgr0)\]\[\033[38;5;21m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
    if [ "$TERM" == 'screen' ]; then
        export PS1=${PS1}'\[\033k\h\033\\\]'
    fi
fi

export MGTL_DOCKER_INSTALL_DIR=${HOME}/mgtl
export MGTL_DASHBOARD_GIT_REPO=git@github.com:sema4genomics/s4-gtl-davros.git
export MGTL_DASHBOARD_GIT_BRANCH=master
export MGTL_DASHBOARD_HOST=$(hostname -f)
export MGTL_DASHBOARD_EMAIL_HOST=$(hostname -f)
export MGTL_DASHBOARD_URL=https://${MGTL_DASHBOARD_HOST}:44300
export MGTL_DASHBOARD_TEST_DIR=$HOME/mgtl/s4-gtl-davrosVerificationTests/test
export MGTL_DASHBOARD_TEST_EMAIL=raymond.lim@mssm.edu
export DOCKER_GROUP=staff # MacOSX. Set to 'docker' on Linux

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.composer/vendor/bin"

export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_144`

alias ika_tunnel='ssh -L 8080:ika.cbio.mskcc.org:29999 xbio'
alias create_xdebug_alias='sudo ifconfig en0 alias 192.168.155.254 255.255.0.0'

convert_audible_aac_to_mp3 () {
    ffmpeg -activation_bytes 624e0c03 -i $1 -acodec libmp3lame $2
}
alias j9="export JAVA_HOME=`/usr/libexec/java_home -v 9`; java -version"
alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
alias j7="export JAVA_HOME=`/usr/libexec/java_home -v 1.7`; java -version"
