#!/bin/bash

REPO_ROOT="./dandelion"

source "$REPO_ROOT/constants.sh"
source "$REPO_ROOT/generic_funcs.sh"

# automate creating or updating config files to local
write_files_to_local() {
  sudo cp $REPO_ROOT/.zshrc ~/.zshrc
  sudo cp $REPO_ROOT/ssh_config ~/.ssh/config
  sudo cp $REPO_ROOT/.gitignore_global ~/.gitignore_global
  sudo cp $REPO_ROOT/vscode_settings.json ~/Library/Application\ Support/Code/User/settings.json

  # create dandelion directory if none
  if [ ! -d "~/dandelion" ]; then
    sudo mkdir ~/dandelion
  fi

  sudo cp $REPO_ROOT/constants.sh ~/dandelion/constants.sh
  sudo cp $REPO_ROOT/generic_funcs.sh ~/dandelion/generic_funcs.sh

  print_message "Setup files applied successfully! ✅" $GREEN
}

# execute functions here
write_files_to_local
