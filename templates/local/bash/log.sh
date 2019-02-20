#!/usr/bin/env bash

# --
# Author
# --
# Iván Jaimes <ivan@iver.mx>
#
# Goal script:  set color environment variables.

set -o errexit
set -o nounset

#Variables
# export green='\033[0;32m'
# export yellow='\033[0;33m'
# export red='\033[0;31m'
# export NC='\033[0m' # No Color

export CLTYPE="\033"

  # command line _eye candy_
 export  NC="${CLTYPE}[0m"        # Text Reset
 export  BLACK="${CLTYPE}[0;30m"  # Black - Regular
 export  RED="${CLTYPE}[0;31m"    # Red
 export  GREEN="${CLTYPE}[0;32m"  # Green
 export  YELLOW="${CLTYPE}[0;33m" # Yellow
 export  BLUE="${CLTYPE}[0;34m"   # Blue
 export  PURPLE="${CLTYPE}[0;35m" # Purple
 export  CYAN="${CLTYPE}[0;36m"   # Cyan
 export  WHITE="${CLTYPE}[0;37m"  # White
 export  BOLD="${CLTYPE}[2;30m"   # Black - Bold

usage() {
  echo "Usage: log.sh [-i|-w|-e|-d] message";
  exit 1;
}

MESSAGE=""
while getopts i:w:e:d: option
do
  case "${option}"
    in
    i) MESSAGE="${GREEN}[INFO]  ${NC} ${OPTARG}";;
    w) MESSAGE="${YELLOW}[WARNING]  ${NC} ${OPTARG}";;
    e) MESSAGE="${RED}[ERROR]  ${NC} ${OPTARG}";;
    d) MESSAGE="${PURPLE}[DEBUG]  ${NC} ${OPTARG}";;
    \?) usage ;;
    :) usage ;;
  esac
done
shift $((OPTIND-1))

if [ -z "${MESSAGE}" ]; then
  usage
fi

echo "$MESSAGE";

