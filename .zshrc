export ZSH="/Users/samlee/.oh-my-zsh"

ZSH_THEME="agnoster"
plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/plugins/git/git.plugin.zsh
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ensure_personal_user_config() {
  git config user.name "Samuel Lee"
  git config user.email "samuelwjlee@gmail.com"
}

ensure_work_user_config() {
  git config user.name "Samuel Lee"
  git config user.email "samlee@housecanary.com"
}

get_curr_branch_name() {
  git rev-parse --abbrev-ref HEAD
}

pull_latest_from_remote() {
  git pull origin $(get_curr_branch_name)
}

cdcw() {
  cd &&
  cd Documents/consumer-web/ &&
  pull_latest_from_remote
}

update_tests_and_css_types() {
  npm run jest-clear-cache &&
  npm run test -- -u &&
  npm run update-css-types &&
}

commit_changes() {
  git add . &&
  git commit -n
}

push_work_code() {
  ensure_work_user_config &&
  update_tests_and_css_types &&
  commit_changes &&
  git push origin $(get_curr_branch_name)
}

push_personal_code() {
  ensure_personal_user_config &&
  commit_changes &&
  git push origin $(get_curr_branch_name)
}

alias diff="git diff"
alias gcod="gco develop && git pull origin develop"
alias gcoq="gco qa && git pull origin qa"
alias start="npm run start"
alias startp="npm run release && npm run serve"
# prints out the pid of anything running on localhost:3000
alias pid="sudo lsof -i -P | grep 3000"