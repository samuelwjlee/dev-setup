#!/bin/bash
# zsh specific config
ZSH="$(echo ~/.oh-my-zsh)"
ZSH_THEME="agnoster"
plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/git/git.plugin.zsh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

DANDELION_ROOT="$(echo ~/dandelion)"
source "$DANDELION_ROOT/constants.sh"
source "$DANDELION_ROOT/generic_funcs.sh"
source "$DANDELION_ROOT/hc_funcs.sh"
source "$DANDELION_ROOT/personal_funcs.sh"

alias diff="git diff"
