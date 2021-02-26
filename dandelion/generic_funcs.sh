#!/bin/bash

print_message() {
  message="$1"
  color="$2"

  echo "\n$color$message\n"
}

kill_process_on_port() {
  port_num="$1"
  npx kill-port "$port_num"
}

get_branch_name() {
  git rev-parse --abbrev-ref HEAD
}

cd_into_repo() {
  cd "$1"
  ensure_correct_user_config "$2"
}

pull_remote() {
  git pull origin $(get_branch_name)
}

push_code() {
  email="$1"
  message="$2"

  ensure_correct_user_config "$email"
  commit_changes "$message"
  git push origin $(get_branch_name)
}

commit_changes() {
  message="$1"
  git add . &&
  git commit -m "$message"
}

ensure_gitignore_global() {
  git config --global core.excludesfile ~/.gitignore_global
}

ensure_correct_user_config() {
  ensure_gitignore_global

  user_email="$1"
  if [ "$user_email" = "$EMAIL_HOUSECANARY" ] || [ "$user_email" = "$EMAIL_SAMUELWJLEE"  ]; then
    add_ssh "$user_email"
    git config user.email "$user_email"
    git config user.name "$USERNAME"
  fi
}

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

stop_all_docker_containers() {
  docker stop $(docker ps -a -q)
}
