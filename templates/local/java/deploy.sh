#!/bin/bash
set -o errexit
set -o nounset

# Using color script environment
. ${SCRIPTS_PATH}/env
source ${SCRIPTS_PATH}/branch_detect.sh

deploy() {
  pcolor "INFO" "Send war to $branch"
  mvn tomcat7:redeploy  -Dmaven.test.skip=true -P ${branch}
}

deploy

exit $?
