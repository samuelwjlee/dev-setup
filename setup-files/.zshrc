# zsh specific config
ZSH="$(echo ~/.oh-my-zsh)"
ZSH_THEME="agnoster"
plugins=(zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/git/git.plugin.zsh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# identification variables
PATH_SSH_KEY_HOUSECANARY="$(echo ~/.ssh/id_rsa_housecanary)"
PATH_SSH_KEY_SAMUELWJLEE="$(echo ~/.ssh/id_rsa_personal)"
EMAIL_HOUSECANARY="samlee@housecanary.com"
EMAIL_SAMUELWJLEE="samuelwjlee@gmail.com"
NAME="Samuel Lee"

add_ssh() {
  if [ "$1" = "$EMAIL_HOUSECANARY" ]; then
    # TODO: update email tied to this ssh key
    if ! ssh-add -l | grep -q "samlee@"; then
      ssh-add "$PATH_SSH_KEY_HOUSECANARY"
    fi
  elif [ "$1" = "$EMAIL_SAMUELWJLEE" ]; then
    if ! ssh-add -l | grep -q "$EMAIL_SAMUELWJLEE"; then
      ssh-add "$PATH_SSH_KEY_SAMUELWJLEE"
    fi
  fi
}

ensure_correct_user_config() {
  if [ "$1" = "$EMAIL_HOUSECANARY" ] || [ "$1" = "$EMAIL_SAMUELWJLEE"  ]; then
    add_ssh "$1"
    git config user.email "$1"
    git config user.name "$NAME"
  fi
}

get_branch_name() {
  git rev-parse --abbrev-ref HEAD
}

pull_remote() {
  git pull origin $(get_branch_name)
}

cdcw() {
  cd &&
  cd Documents/consumer-web/ &&
  ensure_correct_user_config "$EMAIL_HOUSECANARY" &&
  pull_remote
}

commit_changes() {
  git add . &&
  git commit -m "$1"
}

run_test() {
  npm run jest-clear-cache &&
  npm run test -- -u &&
  npm run update-css-types
}

ensure_config_commit_push() {
  email="$1"
  message="$2"

  ensure_correct_user_config "$email" &&
  commit_changes "$message" &&
  git push origin $(get_branch_name)
}

push_work_code() {
  option_or_message="$1"
  message="$2"

  # take option -n to skip test
  if [ "$option_or_message" = "-n" ]; then
    ensure_correct_user_config "$EMAIL_HOUSECANARY" &&
    git add .
    git commit -n
    git push origin $(get_branch_name)
  else
    run_test
    ensure_config_commit_push "$EMAIL_HOUSECANARY" "$option_or_message"
  fi
}

push_personal_code() {
  ensure_config_commit_push "$EMAIL_SAMUELWJLEE" "$1"
}

alias diff="git diff"
alias gcod="gco develop && git pull origin develop"
alias gcoq="gco qa && git pull origin qa"
alias start="npm run start"
alias startp="npm run release && npm run serve"
# prints out the pid of anything running on localhost:3000
# TODO: create a function to kill all processes running on 300
alias pid="sudo lsof -i -P | grep 3000"