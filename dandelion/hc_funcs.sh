#!/bin/bash
DANDELION_ROOT="$(echo ~/dandelion)"
source "$DANDELION_ROOT/constants.sh"
source "$DANDELION_ROOT/generic_funcs.sh"

gcod() {
  ensure_npm_packages_up_to_date
  git checkout develop
  git pull origin develop
}

gcoq() {
  ensure_npm_packages_up_to_date
  git checkout qa
  git pull origin qa
}

cdcw() {
  cd_into_repo "~/Documents/consumer-web/" "$EMAIL_HOUSECANARY"
  ensure_npm_packages_up_to_date
  pull_remote
}

ensure_npm_packages_up_to_date() {
  curr_branch_name="$(get_branch_name)"
  # load changes from remote to local
  git fetch origin "$curr_branch_name"

  # if there are changes in package.json that are about to be pulled in
  if git diff "$curr_branch_name"...origin/"$curr_branch_name" | grep -q package.json; then
    pull_remote
    npm ci
  fi
}

run_test() {
  npm run jest-clear-cache
  npm run test -- -u
  npm run update-css-types
}

push_work_code() {
  option_or_message="$1"
  curr_branch_name="$(get_branch_name)"

  # halt if direct push to develop, qa, or master branch
  if [ "$curr_branch_name" = "develop" ] ||
     [ "$curr_branch_name" = "qa" ] ||
     [ "$curr_branch_name" = "master" ]; then
    clear
    print_message"You sure you want to push directly to $curr_branch_name?" "$RED"
    read
  fi

  # take option -n as first arg to skip test
  if [ "$option_or_message" = "-n" ]; then
    # second arg, if given, is the commit message
    message="$2"

    npm run update-css-types
    ensure_correct_user_config "$EMAIL_HOUSECANARY"
    git add .
    git commit -n -m "$message"
    git push origin "$curr_branch_name"
  else
    run_test
    push_code "$EMAIL_HOUSECANARY" "$option_or_message"
  fi
}

start() {
  ensure_npm_packages_up_to_date
  npm run start
}
