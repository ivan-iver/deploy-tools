#/bin/bash

# Copyright (c) 2015 Iván Jaimes, https://iver.mx. See LICENSE file.
#
# This is a skeleton of a bash deploy script and is part of a scripts collection.
# If you wish to know more about it please visit https://github.com/ivan-iver/deploy-tools
# To use for yourself, just set the scripts variables and then run it.
set -o errexit
set -o nounset

export ACTUAL=`pwd`
export PKG=api.tar.gz
export BUILD_PATH=${ACTUAL}/.travis/
export DEPLOY_PATH=/var/www/api/

export USER=deploy
export USER_WEB=www-data
export SSH_KEY=deploy.rsa
export PORT=22

# Using color script environment
. ${SCRIPTS_PATH}/env

[ -n "${TRAVIS_BUILD_DIR-}" ] || TRAVIS_BUILD_DIR=${ACTUAL}

echo -e "${PURPLE}TRAVIS_BUILD_DIR ${NC} -> ${TRAVIS_BUILD_DIR}"

RAMA=`git branch -a| grep \* | cut -d ' ' -f2`;

if [[ "${RAMA}" == *"HEAD"* ]] || [[ "${RAMA}" == *"detached"* ]]; then
  RAMA=${TRAVIS_BRANCH}
fi

if [ "${RAMA}" = "master" ]; then
  export branch=prod
elif [[ "${RAMA}" == *"release"* ]]; then
  export branch=uat
else
  export branch=dev
fi

echo -e "${YELLOW}INFO${NC} Evironment ${PURPLE}${branch}${NC} and branch ${PURPLE}${RAMA}${NC}";

if [ ! -f $PKG ]; then
  echo "API files are not yet ready. Use make package."
  exit 0;
fi

RAMA=`git branch -a| grep \* | cut -d ' ' -f2`;

echo "Rama->${RAMA}";

if [[ "${RAMA}" == *"HEAD"* ]] || [[ "${RAMA}" == *"detached"* ]]; then
  RAMA=${TRAVIS_BRANCH}
fi

echo "Current branch is: ${RAMA}";

if [ "${RAMA}" = "master" ]; then
  TARGET=api.lidcorp.lat
else
  TARGET=api.dev.lidcorp.lat
fi

export TARGET

echo "Sending files to server";
scp -vv -P ${PORT} -i ${BUILD_PATH}${SSH_KEY} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${PKG} $USER@$TARGET:/tmp;
ssh -vv -p ${PORT} -i ${BUILD_PATH}${SSH_KEY} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -l $USER $TARGET "
  sudo /usr/local/bin/deploy.sh > /var/www/api/deploy.log 2>&1
";

echo "Remove package from local host."
rm -f ${PKG}

echo "Done!";
