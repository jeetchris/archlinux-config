#
# ~/.bashrc
#

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Auto-complétion
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh

## Variables d'environnement
export EDITOR='vim'
export HISTCONTROL='ignoredups'
export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export GEM_HOME=$(ruby -e 'print Gem.user_dir')
export PATH=$PATH:~/.gem/ruby/2.2.0/bin:~/.gem/ruby/2.2.0/gems

## Affichage du PS1
# Originel
#PS1='[\u@\h \W]\$ '
# Sans git
#PS1='\e[01;32m\u@\h\e[0m:\e[01;34m\w\e[m\$ '
# Avec git
PS1='\e[1;32m\u@\h\e[0m:\e[1;34m\w\e[0m\e[33m$(__git_ps1 " (%s)")\e[0m\$ '

## Alias de commandes
alias ls='ls --color=auto'
alias ll='ls -alFh --group-directories-first'
alias grep='grep --color=auto'
