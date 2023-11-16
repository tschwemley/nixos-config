#!/usr/bin/env zsh

if [[ "$1" == "--menu" ]]; then
	rofi -show drun
elif [[ "$1" == "--search" ]]; then
	brave --new-tab "https://search.schwem.io"
fi
