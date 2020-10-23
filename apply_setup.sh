#!/bin/bash

REPO_ROOT="./setup-files"
source "$REPO_ROOT/constants.sh"

# automate creating or updating config files to local
write_files_to_local() {
  sudo cp $REPO_ROOT/.zshrc ~/.zshrc
  sudo cp $REPO_ROOT/ssh_config ~/.ssh/config
  sudo cp $REPO_ROOT/.gitignore_global ~/.gitignore_global
  sudo cp $REPO_ROOT/vscode_settings.json ~/Library/Application\ Support/Code/User/settings.json
  sudo cp $REPO_ROOT/constants.sh ~/constants.sh

  print_message "Setup files applied successfully! ✅" $GREEN
}

# execute functions here
write_files_to_local
