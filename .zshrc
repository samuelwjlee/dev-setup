export ZSH="/Users/samlee/.oh-my-zsh"

ZSH_THEME="agnoster"
plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/plugins/git/git.plugin.zsh
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

parse_git_branch() {
 git rev-parse --abbrev-ref HEAD
}

pull_latest_from_remote() {
 git pull origin $(parse_git_branch)
}

cdcw() {
 cd && cd Documents/consumer-web/ && pull_latest_from_remote
}

alias diff="git diff"
alias gcod="gco develop && git pull origin develop"
alias gcoq="gco qa && git pull origin qa"
alias start="npm run start"
alias startp="npm run release && npm run serve"
alias pid="sudo lsof -i -P | grep 3000"
