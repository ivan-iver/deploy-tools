#!/bin/bash
set -o errexit
set -o nounset

# Using color script environment
. ${SCRIPTS_PATH}/env

LIBS=${ACTUAL}/libs/
JARS=${LIBS}*.jar
VENDOR_GROUP=mx.com.vendor

install() {
  for f in ${JARS}
  do
    artifact=$(basename "${f%.jar}")
    # echo "File: ${f} Filename: ${f##*/} Name: ${artifact}"
    mvn install:install-file -Dfile=${f} -DgroupId=${VENDOR_GROUP} -DartifactId=${artifact} -Dversion=1.0 -Dpackaging=jar
  done
}

install

exit $?
