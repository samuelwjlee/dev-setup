#!/bin/bash
# This script has a list of apps that will be installed to a target machine

APPS_TO_INSTALL=(
  "google-chrome"
  "brave-browser"
  "visual-studio-code"
  "iterm2"
  "spotify"
)

LIGHT_BLUE='\033[1;34m'

print_message() {
  clear
  message="$1"
  echo "\n${LIGHT_BLUE}$message...\n"
}

ensure_xcode_homebrew() {
  # check if xcode is installed and install if needed
  if ! which xcodebuild | grep -q "/xcodebuild"; then
    print_message "Now installing xcode"
    xcode-select --install
  fi

  # check if homebrew is installed and install if needed
  if ! which brew | grep -q "/brew"; then
    print_message "Now installing homebrew"
    mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
  fi
}

install_apps() {
  ensure_xcode_homebrew

  for app_name in ${APPS_TO_INSTALL[*]}
  do
    print_message "Now installing $app_name"
    # TODO: spike on how to do this synchronously
    # brew cask install $app_name
  done
}

install_apps
