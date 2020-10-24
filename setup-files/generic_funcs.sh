#!/bin/bash
source ~/constants.sh

print_message() {
  message="$1"
  color="$2"

  echo "\n$color$message\n"
}
