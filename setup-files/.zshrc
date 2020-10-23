# zsh specific config
ZSH="$(echo ~/.oh-my-zsh)"
ZSH_THEME="agnoster"
plugins=(zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/git/git.plugin.zsh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/constants.sh

add_ssh() {
  user_email="$1"
  if [ "$user_email" = "$EMAIL_HOUSECANARY" ]; then
    # TODO: update email tied to this ssh key
    if ! ssh-add -l | grep -q "samlee@"; then
      ssh-add "$PATH_SSH_KEY_HOUSECANARY"
    fi
  elif [ "$user_email" = "$EMAIL_SAMUELWJLEE" ]; then
    if ! ssh-add -l | grep -q "$EMAIL_SAMUELWJLEE"; then
      ssh-add "$PATH_SSH_KEY_SAMUELWJLEE"
    fi
  fi
}

ensure_correct_user_config() {
  user_email="$1"
  if [ "$user_email" = "$EMAIL_HOUSECANARY" ] || [ "$user_email" = "$EMAIL_SAMUELWJLEE"  ]; then
    add_ssh "$user_email"
    git config user.email "$user_email"
    git config user.name "$USERNAME"
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
  message="$1"
  git add . &&
  git commit -m "$message"
}

run_test() {
  npm run jest-clear-cache &&
  npm run test -- -u &&
  npm run update-css-types
}

push_code() {
  email="$1"
  message="$2"

  ensure_correct_user_config "$email" &&
  commit_changes "$message" &&
  git push origin $(get_branch_name)
}

push_work_code() {
  option_or_message="$1"
  curr_branch_name="$(get_branch_name)"

  # check and halt if this is a direct push
  if [ "$curr_branch_name" = "develop" ] || [ "$curr_branch_name" = "qa" ] || [ "$curr_branch_name" = "master" ]; then
    clear
    print_message "You sure you want to push directly to $curr_branch_name?" "$RED"
    read
  fi

  # take option -n as first arg to skip test
  if [ "$option_or_message" = "-n" ]; then
    # second arg, if given, is the commit message
    message="$2"

    ensure_correct_user_config "$EMAIL_HOUSECANARY" &&
    git add . &&
    git commit -n -m "$message" &&
    git push origin "$curr_branch_name"
  else
    run_test &&
    push_code "$EMAIL_HOUSECANARY" "$option_or_message"
  fi
}

push_personal_code() {
  message="$1"
  push_code "$EMAIL_SAMUELWJLEE" "$message"
}

kill_process_on_port() {
  port_num="$1"
  process_list=$(sudo lsof -t -i:"$port_num")

  if [ "$process_list" = "" ]; then
    print_message "No process to kill. We're all good here 👌🏼." "$GREEN"
  else
    sudo kill -9 "$process_list"
    print_message "All process running on $port_num terminated ✅" "$GREEN"
  fi
}

alias diff="git diff"
alias gcod="gco develop && git pull origin develop"
alias gcoq="gco qa && git pull origin qa"
alias start="npm run start"
