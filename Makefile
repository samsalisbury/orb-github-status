SHELL := /usr/bin/env bash -euo pipefail

.PHONY: validate test

CCI_VERSION := $(shell circleci version)
ifeq ($(CCI_VERSION),)
$(error Unable to determine circleci-cli version)
endif

CCI := .make/cci-version-$(CCI_VERSION)

ORB_FILE := orbs/github-status.yml
ORB_NAME := samsalisbury/github-status
ORB_VERSION := $(shell git describe --dirty)
ORB_VERSION_DIRTY := $(shell git describe --dirty)
CLEAN := NO
# If these are equal, we are not dirty.
ifeq ($(ORB_VERSION),$(ORB_VERSION_DIRTY))
CLEAN := YES
ORB_EXACT_VERSION := $(shell git describe --exact-match --dirty 2>/dev/null)
endif

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

publish:
	[ -n "$(ORB_EXACT_VERSION)" ] || { echo "Not on exact git tag, cannot publish."; exit 1; }
	circleci orb publish $(ORB_FILE) $(ORB_NAME):$(ORB_EXACT_VERSION)

publish-dev:
	[ $(CLEAN) = YES ] || { echo "Repo dirty, cannot publish dev version."; exit 1; }
	circleci orb publish $(ORB_FILE) $(ORB_NAME):dev:$(ORB_VERSION)
