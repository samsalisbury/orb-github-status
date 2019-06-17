SHELL := /usr/bin/env bash -euo pipefail

.PHONY: validate test

CCI_VERSION := $(shell circleci version)
ifeq ($(CCI_VERSION),)
$(error Unable to determine circleci-cli version)
endif

CCI := .make/cci-version-$(CCI_VERSION)

# Source contains all input yml files, this Makefile itself
# and the current version of the circleci CLI tool.
SOURCE := Makefile $(CCI) $(shell find . -type f -name '*.yml' -not -path './.circleci/*')

$(CCI):
	mkdir -p $(shell dirname $@); touch $@

validate: $(SOURCE)
	# Validate the orb itself.
	circleci orb validate orbs/github-status.yml
	# Check we can pack and process and still have a vaild config.
	circleci config pack . | circleci config process - | circleci config validate - > /dev/null

test: validate
