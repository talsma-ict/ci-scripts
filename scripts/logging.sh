#!/bin/bash

#
# Script containing basic logging and debugging features
#

SCRIPTNAME=$(basename ${0%.*})

# Set colors if supported by the terminal and output is not redirected somewhere else
bold="";underline="";standout="";normal="";black="";red="";green="";yellow="";blue="";magenta="";cyan="";white=""
if [[ "${FORCE_COLOR:-false}" =~ ^yes|true$ || -t 1 ]]; then
    ncolors=$(tput colors)
#    if [[ -n "$ncolors" && $ncolors -ge 8 ]]; then
        bold="$(tput bold)";underline="$(tput smul)";standout="$(tput smso)";normal="$(tput sgr0)"
        black="$(tput setaf 0)";red="$(tput setaf 1)";green="$(tput setaf 2)";yellow="$(tput setaf 3)"
        blue="$(tput setaf 4)";magenta="$(tput setaf 5)";cyan="$(tput setaf 6)";white="$(tput setaf 7)"
#    fi
    unset ncolors
fi

log() {
    local level="${2:-INFO}"
    local color="${normal}"
    case ${level} in
      INFO) local color="${normal}${green}";;
      WARNING) local color="${normal}${magenta}";;
      ERROR) local color="${normal}${bold}${red}";;
    esac
    [ "${level}" = "DEBUG" ] || echo "${color}[${level}] ${bold}${SCRIPTNAME}${color}: ${1:-}${normal}" 1>&2
}

debug() {
    log "${1:-}" "${2:-DEBUG}"
}

warn() {
    log "${1:-}" "${2:-WARNING}"
}

fatal() {
    log "${1:-}" "${2:-ERROR}"
    exit 1
}
