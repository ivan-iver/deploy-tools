#!/bin/bash

set -o errexit
set -o nounset

HASH=`git rev-parse --short HEAD`
TAGS=`git fetch --tags`

if [[ -z "`git tag --list`" ]]; then
  VERSION="0.0.0"
  pcolor "INFO" "No hay tags"
else
  VERSION=`git describe --tags $(git rev-list --tags --max-count=1) | cut -d'-' -f2`
fi

VERSION_NAME="${VERSION}-(${HASH})"
FULL_VERSION="name:${VERSION_NAME}-hash:${HASH}"

pcolor "DEBUG" "Variable FULL_VERSION: ${FULL_VERSION}"

FILE=${ACTUAL}/version.properties

pcolor "INFO" "${PURPLE}[API][Version]${NC} Create version.properties       |${RED} Start ${NC}"
[ -f ${FILE} ] && rm -f ${FILE};
cat > ${FILE} << EOF
version=${VERSION_NAME}
EOF

pcolor "INFO" "${PURPLE}[API][Version]${NC} Setted version as ${VERSION_NAME}"
pcolor "INFO" "${PURPLE}[API][Version]${NC} Created version.properties file |${RED} Done! ${NC}"

