#!/bin/bash

DANDELION_ROOT="$(echo ~/dandelion)"
source "$DANDELION_ROOT/constants.sh"
source "$DANDELION_ROOT/generic_funcs.sh"

cdda() {
  cd_into_repo "$(echo ~/Documents/dandelion/)" "$EMAIL_SAMUELWJLEE"
  pull_remote
}

cdwf() {
  cd_into_repo "$(echo ~/Documents/wordful/)" "$EMAIL_SAMUELWJLEE"
  pull_remote
}

push_personal_code() {
  message="$1"
  push_code "$EMAIL_SAMUELWJLEE" "$message"
}
