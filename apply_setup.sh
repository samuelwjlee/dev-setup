#!/bin/bash

# path variables
REPO_ROOT="./setup-files"

# ANSI escape codes
# https://en.wikipedia.org/wiki/ANSI_escape_code
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

GREEN='\033[0;32m'

# automate creating or updating config files to local
write_files_to_local() {
  sudo cp $REPO_ROOT/.zshrc ~/.zshrc
  sudo cp $REPO_ROOT/ssh_config ~/.ssh/config
  sudo cp $REPO_ROOT/.gitignore_global ~/.gitignore_global
  sudo cp $REPO_ROOT/vscode_settings.json ~/Library/Application\ Support/Code/User/settings.json

  echo "${GREEN}✅✅✅ SUCCESS! ✅✅✅\n"
}

# execute functions here
write_files_to_local