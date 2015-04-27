#
# ~/.bashrc
#

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Affichage du PS1
# Originel
#PS1='[\u@\h \W]\$ '
# Sans git
PS1='\[\e[01;31m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w\[\e[m\]\$ '

## Alias de commandes
alias ls='ls --color=auto'
alias ll='ls -alFh --group-directories-first'
alias grep='grep --color=auto'
