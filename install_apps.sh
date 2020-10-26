#!/bin/bash
source ./constants.sh
source ./generic_funcs.sh

APPS_TO_INSTALL=(
  "google-chrome"
  "brave-browser"
  "visual-studio-code"
  "iterm2"
  "spotify"
  "alfred"
)

ensure_xcode_homebrew() {
  # check if xcode is installed and install if needed
  if ! which xcodebuild | grep -q "/xcodebuild"; then
    print_message "Now installing xcode" $LIGHT_BLUE
    xcode-select --install
  fi

  # check if homebrew is installed and install if needed
  if ! which brew | grep -q "/brew"; then
    print_message "Now installing homebrew" $LIGHT_BLUE
    mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
  fi
}

install_apps() {
  ensure_xcode_homebrew

  for app_name in ${APPS_TO_INSTALL[*]}
  do
    print_message "Now installing $app_name" $LIGHT_BLUE
    # TODO: spike on how to do this synchronously
    # brew cask install $app_name
  done
}

install_apps
