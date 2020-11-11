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
