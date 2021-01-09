#!/bin/bash
DANDELION_ROOT="$(echo ~/dandelion)"
source "$DANDELION_ROOT/constants.sh"
source "$DANDELION_ROOT/generic_funcs.sh"

cdda() {
  cd ~/Documents/dandelion/
  ensure_correct_user_config "$EMAIL_SAMUELWJLEE"
  pull_remote
}

cdwf() {
  cd ~/Documents/wordful/
  ensure_correct_user_config "$EMAIL_SAMUELWJLEE"
  pull_remote
}

push_personal_code() {
  message="$1"
  push_code "$EMAIL_SAMUELWJLEE" "$message"
}
