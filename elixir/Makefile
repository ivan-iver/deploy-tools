SHELL := /bin/bash
ACTUAL := $(shell pwd)
MIX_ENV=prod

export MIX_ENV
export ACTUAL

all: release

clean:
	mix deps.clean --all

version:
	git rev-parse --short HEAD > $$ACTUAL/web/templates/page/index.html.eex

compile: version
	mix deps.get
	mix deps.compile
	mix compile

release: clean compile
	brunch build --production
	mix phoenix.digest
	mix release
	@echo "Release MIX_ENV=${MIX_ENV} generated!"
