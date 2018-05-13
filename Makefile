SHELL := bash
ACTUAL := $(shell pwd)

# Exports as global variables used from build scripts
export ACTUAL
export SCRIPTS_PATH=${ACTUAL}/scripts
export TEST_PATH=${ACTUAL}/test

help:
	@echo ""

build:
	@${SCRIPTS_PATH}/build.sh

run:
	# Add run logic here

install:
	# Add install logic here

clean:
	@rm -r test ${PKGNAME} $(DIR_DATE);

