#!/bin/bash
set -o errexit
set -o nounset

# Using color script environment
. ${SCRIPTS_PATH}/env

. ${SCRIPTS_PATH}/set_version.sh
source ${SCRIPTS_PATH}/branch_detect.sh

pcolor "INFO" "Evironment ${PURPLE}${branch}${NC} and branch ${PURPLE}${RAMA}${NC}";

LOG_DIR=/opt/tomcat/logs

build(){
  pcolor "INFO" "Build package from $branch"
  mvn install -e -DLogDirectory=${LOG_DIR} -B -V -P${branch}
}

build

exit $?
