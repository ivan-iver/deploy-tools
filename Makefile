SHELL := bash

ACTUAL := $(shell pwd)
PKGNAME := api.tar.gz

# Exports as global variables used from build scripts
export ACTUAL
export PKGNAME
export SCRIPTS_PATH=${ACTUAL}/scripts
export TEST_PATH=${ACTUAL}/test

DATE=`date +%Y-%m-%d`
DIR_DATE=${DATE}*

build:
	@${SCRIPTS_PATH}/build.sh

run:
	# Add run logic here

install:
	# Add install logic here

clean:
	@rm -r test ${PKGNAME} $(DIR_DATE);

