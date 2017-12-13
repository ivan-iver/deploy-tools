#!/bin/bash
set -o errexit
set -o nounset

# Using color script environment
. ${SCRIPTS_PATH}/env

. ${SCRIPTS_PATH}/set-version.sh
source ${SCRIPTS_PATH}/branch-detect.sh

pcolor "INFO" "Evironment ${PURPLE}${branch}${NC} and branch ${PURPLE}${RAMA}${NC}";

build(){
	case $branch in
		dev)
        # Add build logic here
			;;
    uat)
        # Add build logic here
			;;
		prod)
        # Add build logic here
			;;
	esac
}

build

exit $?
