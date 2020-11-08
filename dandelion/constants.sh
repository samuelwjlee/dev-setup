#!/bin/bash

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

# color definitions
GREEN='\033[0;32m'
LIGHT_BLUE='\033[1;34m'
RED='\033[0;31m'

# identification variables
PATH_SSH_KEY_HOUSECANARY="$(echo ~/.ssh/id_rsa_housecanary)"
PATH_SSH_KEY_SAMUELWJLEE="$(echo ~/.ssh/id_rsa_personal)"
EMAIL_HOUSECANARY="samlee@housecanary.com"
EMAIL_SAMUELWJLEE="samuelwjlee@gmail.com"
USERNAME="Samuel Lee"
