# Nick Savage's .bash_profile
# Last updated:
# February 16, 2016

PATH=/usr/local/scripts/:/bin:/usr/bin:/sbin:/usr/bin/perlbin/site:~/scripts/:/usr/bin/perlbin/vendor:/usr/bin/perlbin/core:/usr/sbin:/usr/local/bin:/opt/android-sdk-linux/platform-tools:/usr/games/

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    export GREP_OPTIONS='--color=auto'
    eval `dircolors ~/.dir_colors`
fi


black="\[\e[0;30m\]"
BLACK="\[\e[1;30m\]"
red="\[\e[0;31m\]"
RED="\[\033[1;31m\]"
green="\[\e[0;32m\]"
GREEN="\[\e[1;32m\]"
yellow="\[\e[0;33m\]"
YELLOW="\[\e[1;33m\]"
blue="\[\e[0;34m\]"
BLUE="\[\e[1;34m\]"
purple="\[\e[0;35m\]"
PURPLE="\[\e[1;35m\]"
cyan="\[\e[0;36m\]"
CYAN="\[\033[1;36m\]"
white="\[\e[0;37m\]"
WHITE="\[\e[1;37m\]"
NOCOLOR="\[\033[00m\]"

if [[ $EUID -ne 0 ]]; then
    export PS1="\\[$GREEN\h $CYAN\W \$ $NOCOLOR"
else
    export PS1="\\[$RED\h $CYAN\W \$ $NOCOLOR"
fi

alias ..="cd ../"
alias ....="cd ../../"
alias ......="cd ../../../"
alias ed="emacs --daemon"
alias ec="emacsclient -nw"
alias emacs="emacs -nw"
alias ls="ls $LS_OPTIONS"
alias grep="grep --color=auto"
alias t="topydo"

export GREP_COLOR="1;33"
export LS_OPTIONS="$LS_OPTIONS -hF"
export GREP_OPTIONS="$GREP_OPTIONS"
export BROWSER="firefox"
export EDITOR="emacs -nw"
export LEDGER_FILE="~/hledger/ledger"
export TODOTXT_FINAL_FILTER='$HOME/.todo/filters/futureTasks'
export TODOTXT_DEFAULT_ACTION=ls
export TERM=linux
