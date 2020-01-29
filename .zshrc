export ZSH="/Users/samlee/.oh-my-zsh"

ZSH_THEME="agnoster"
plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/plugins/git/git.plugin.zsh
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias gcod="gco develop && git pull origin develop"
alias start="npm run start"
