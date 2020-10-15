#!/bin/bash
# This script has a list of apps that will be installed to a target machine

APPS_TO_INSTALL=(
  "google_chrome"
  "brave_browser"
  "visual_studio_code"
  "iTerm2"
  "slack"
  "Spotify"
)

LIGHT_BLUE='\033[1;34m'

ensure_xcode_homebrew() {
  # check if xcode is installed and install if needed
  if ! which xcodebuild | grep -q "/xcodebuild"; then
    echo "${LIGHT_BLUE}Installing xcode..."
    xcode-select --install
  fi

  # check if homebrew is installed and install if needed
  if ! which brew | grep -q "/brew"; then
    echo "${LIGHT_BLUE}Installing homebrew..."
    mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
  fi
}

install_apps() {
  echo "${LIGHT_BLUE}Installing $1...\n"
}

run() {
  ensure_xcode_homebrew

  for app_name in ${APPS_TO_INSTALL[*]}
  do
    # download command here
    echo "${LIGHT_BLUE}Downloading $app_name...\n"
    install_apps $app_name
  done
}

run