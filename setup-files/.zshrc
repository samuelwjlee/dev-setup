ZSH="/Users/samlee/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/git/git.plugin.zsh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

NAME="Samuel Lee"
EMAIL_HOUSECANARY="samlee@housecanary.com"
EMAIL_SAMUELWJLEE="samuelwjlee@gmail.com"
SSH_KEY_PATH_HOUSECANARY="~/.ssh/id_rsa_housecanary"
SSH_KEY_PATH_SAMUELWJLEE="~/.ssh/id_rsa_personal"

add_ssh() {
  if [ $1 = "$EMAIL_HOUSECANARY" ]; then
    # TODO: update email tied to this ssh key
    if ! ssh-add -l | grep -q "samlee@"; then
      ssh-add $SSH_KEY_PATH_HOUSECANARY
    fi
  elif [ $1 = "$EMAIL_SAMUELWJLEE" ]; then
    if ! ssh-add -l | grep -q $EMAIL_SAMUELWJLEE; then
      ssh-add $SSH_KEY_PATH_SAMUELWJLEE
    fi
  fi
}

ensure_work_user_config() {
  add_ssh $EMAIL_HOUSECANARY
  git config user.name $NAME
  git config user.email $EMAIL_HOUSECANARY
}

ensure_personal_user_config() {
  add_ssh $EMAIL_SAMUELWJLEE
  git config user.name $NAME
  git config user.email $EMAIL_SAMUELWJLEE
}

get_curr_branch_name() {
  git rev-parse --abbrev-ref HEAD
}

pull_remote() {
  git pull origin $(get_curr_branch_name)
}

cdcw() {
  cd &&
  cd Documents/consumer-web/ &&
  ensure_work_user_config &&
  pull_remote
}

update_tests_and_css_types() {
  npm run jest-clear-cache &&
  npm run test -- -u &&
  npm run update-css-types &&
}

commit_changes() {
  git add . &&
  git commit -m $1
}

push_work_code() {
  ensure_work_user_config &&
  update_tests_and_css_types &&
  commit_changes $1 &&
  git push origin $(get_curr_branch_name)
}

push_personal_code() {
  ensure_personal_user_config &&
  commit_changes $1 &&
  git push origin $(get_curr_branch_name)
}

alias diff="git diff"
alias gcod="gco develop && git pull origin develop"
alias gcoq="gco qa && git pull origin qa"
alias start="npm run start"
alias startp="npm run release && npm run serve"
# prints out the pid of anything running on localhost:3000
alias pid="sudo lsof -i -P | grep 3000"