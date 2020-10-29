#!/bin/bash
source ~/constants.sh

print_message() {
  message="$1"
  color="$2"

  echo "\n$color$message\n"
}

kill_process_on_port() {
  port_num="$1"
  process_list=$(sudo lsof -t -i:"$port_num")

  if [ "$process_list" = "" ]; then
    print_message "No process to kill 🔪. We're all good here 👍🏼." "$GREEN"
  else
    sudo kill -9 "$process_list"
    print_message "All process running on $port_num terminated ✅" "$GREEN"
  fi
}

get_branch_name() {
  git rev-parse --abbrev-ref HEAD
}

pull_remote() {
  git pull origin $(get_branch_name)
}

commit_changes() {
  message="$1"
  git add . &&
  git commit -m "$message"
}

ensure_gitignore_global() {
  git config --global core.excludesfile ~/.gitignore_global
}
