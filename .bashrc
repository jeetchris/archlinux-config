#
# ~/.bashrc
#

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## RVM
source $HOME/.rvm/scripts/rvm

## Auto-complétion
# git
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh
# rvm
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"

## Variables d'environnement
export EDITOR='vim'
export HISTCONTROL='ignoredups'
export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export rvm_ignore_gemrc_issues=1

## Affichage du PS1
# Bien ouvrir et refermer autour des codes couleur avec \[ \] pour éviter les problèmes d'affichages lors de retour dans l'historique
# Originel
#PS1='[\u@\h \W]\$ '
# Sans git
#PS1='\[\e[01;32m\]\u@\h\[\e[0m\]:\[\e[01;34m\]\w\[\e[m\]\$ '
# Avec git
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\[\e[33m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '
# Avec rvm
#PS1="\$($HOME/.rvm/bin/rvm-prompt) $PS1"

## Alias de commandes
alias ls='ls --color=auto'
alias ll='ls -alFh --group-directories-first'
alias grep='grep --color=auto'
