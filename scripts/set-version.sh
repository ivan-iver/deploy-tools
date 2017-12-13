#!/bin/bash
set -o errexit
set -o nounset

export PROJECT_PATH=${ACTUAL};

CONFIG=${PROJECT_PATH}/package.json
VERSION_FILE=${PROJECT_PATH}/version.html

HASH=`git rev-parse --short HEAD`
TAGS=`git fetch --tags`

if [[ -z "`git tag --list`" ]]; then
  VERSION="0.0.0"
  echo "No hay tags"
else
  VERSION=`git describe --tags $(git rev-list --tags --max-count=1) | cut -d'-' -f2`
fi

VERSION_NAME="${VERSION}-(${HASH})"
FULL_VERSION="name:${VERSION_NAME}-hash:${HASH}"

pcolor "DEBUG" "Variable FULL_VERSION: ${FULL_VERSION}"
pcolor "DEBUG" "Configuration file: ${CONFIG}"

unamestr=`uname -s`;

echo "Uname -> $unamestr";

if [[ "$unamestr" == 'Linux' ]]; then
	jq ".version = \"${VERSION}\"" ${CONFIG} > tmp.$$.json && mv tmp.$$.json ${CONFIG}
	jq ".versionName = \"${VERSION_NAME}\"" ${CONFIG} > tmp.$$.json && mv tmp.$$.json ${CONFIG}
elif [[ "$unamestr" == 'Darwin' ]]; then
	jq ".version = \"${VERSION}\"" ${CONFIG} > tmp.$$.json && mv tmp.$$.json ${CONFIG}
	jq ".versionName = \"${VERSION_NAME}\"" ${CONFIG} > tmp.$$.json && mv tmp.$$.json ${CONFIG}
fi

echo "{ version: ${VERSION_NAME} }" > ${VERSION_FILE};

head ${CONFIG}

