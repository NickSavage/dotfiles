#!/bin/bash

eval $(dircolors -b)

case "$TERM" in
    rxvt-256color)
        TERM=rxvt-unicode
        ;;
esac

if [ -f ~/.bash_profile ]; then
	source ~/.bash_profile
fi