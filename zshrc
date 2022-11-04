source ~/.git-prompt.sh
alias pd="pushd"
alias bd="popd"

export HISTIGNORE="&:ls:[bf]g:exit:bd:h:ll"

umask 002
export EDITOR=nvim
export PAGER=less
set -o vi
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
alias ll="ls -alG"
alias ls='ls -FG'
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

PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
export DOCKER_GROUP=staff # MacOSX. Set to 'docker' on Linux

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.composer/vendor/bin"

#export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_144`


convert_audible_aac_to_mp3 () {
    ffmpeg -activation_bytes 624e0c03 -i $1 -acodec libmp3lame $2
}
#alias j9="export JAVA_HOME=`/usr/libexec/java_home -v 9`; java -version"
#alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
#alias j7="export JAVA_HOME=`/usr/libexec/java_home -v 1.7`; java -version"
