#!/usr/bin/env bash

# --
# Author
# --
# Iván Jaimes <ivan@iver.mx>
#
# Goal script:  detect current branch.
set -o errexit
set -o nounset

branch=""
default="develop"
milieu=""

usage() {
  echo -e "Usage: branch_detect.sh -d <default_branch>"
  echo -e "   -d  Default branch when is [empty] is set to develop"
  echo -e "   -h  help."
  exit 1
}

contains() {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == "$seeking" ]]; then
            in=0
            break
        fi
    done
    return $in
}

check_params() {
  arr_default=( "develop" "master" )
  contains arr_default "${default}" || usage
}

get_params() {
  while getopts ":d:h:" o; do
    case "${o}" in
      d ) default=${OPTARG};;
      h | * ) usage
        exit 0
        ;;
    esac
  done
}

get_branch() {
  branch=$(git branch -a| grep \* | cut -d ' ' -f2);
  if [[ "${branch}" == *"HEAD"* ]] || [[ "${branch}" == *"detached"* ]]; then
    branch=${default}
  fi
  echo "${branch}"
}

get_env() {
  if [[ "${branch}" == "master" ]]; then
    milieu=prod
  elif [[ "${branch}" == *"release"* ]]; then
    milieu=uat
  else
    milieu=dev
  fi
  echo "${milieu}"
}

main() {
  get_params "$@"
  check_params
  get_env
}

main "$@"
