#!/bin/bash
# This script has a list of apps that will be installed to a target machine

APPS_TO_INSTALL=(
  "google_chrome"
  "brave_browser"
)

# print out download / install status
for app in ${APPS_TO_INSTALL[*]}
do
    printf "Downloading %s...\n" $app
done

# execute command to download and install apps in APPS_TO_INSTALL