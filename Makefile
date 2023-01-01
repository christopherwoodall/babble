#!/usr/bin/make -f
# -*- makefile -*-

SHELL         := /bin/bash
.SHELLFLAGS   := -eu -o pipefail -c
.DEFAULT_GOAL := help
.LOGGING      := 1

.ONESHELL:             ;  # Recipes execute in same shell
.NOTPARALLEL:          ;  # Wait for this target to finish
.SILENT:               ;  # No need for @
.EXPORT_ALL_VARIABLES: ;  # Export variables to child processes.
.DELETE_ON_ERROR:      ;  # Delete target if recipe fails.

# MAKEFLAGS += --warn-undefined-variables # DEBUGGING
# MAKEFLAGS += --no-builtin-rules         # DEBUGGING

# Modify the block character to be `-\t` instead of `\t`
ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This version of Make does not support .RECIPEPREFIX.)
endif
.RECIPEPREFIX = -

ifeq ($(OS),Windows_NT)
SHELL := powershell.exe
.SHELLFLAGS := -NoProfile -Command
.DEFAULT_GOAL := windows
.LOGGING :=
$(warning WIP: Windows support is not yet available.)
endif


define Logging
	echo"📝 Enabling logs..."
	if [[ $(.LOGGING) -eq 1 ]]; then
		mkdir -p `dirname $1`
		exec 1> >(tee -a $1) 2>&1
	else
		echo "Logging disabled"
	fi

endef


define Lint
	echo"🧼 Linting project code..."
	python3 -m black $1
endef


define Environment
	echo"🐍 Setting up virtual environment..."
	if [ ! -d "$1" ]; then
 		echo"🐍 Installing Python virtual environment package..."
		python3 -m pip install venv
		python3 -m venv venv
	fi
	source venv/bin/activate
	python3 -m pip install --upgrade pip
	python3 -m pip install -e .
endef


default: $(.DEFAULT_GOAL)
all: help


.PHONY: help
help: ## List commands
-	$(call Logging,./logs/$(shell date +%Y-%m-%d).log)
-	echo"USAGE: make [COMMAND]\n"
-	echo "Available commands:"
-	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\t%-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)


PHONY: update
update: ## git pull branch
-	echo"🆕 Updating branch..."
-	git pull origin `git config --get remote.origin.url`


PHONY: model-server
model-server: ## Host a model server on localhost:9000
-	echo"🫧 Updating branch..."
-	docker compose up babble


PHONY: test-siem
test-siem: ## Launch a test SIEM on localhost:8000
-	echo"🌐 Updating branch..."
-	docker compose --profile test-siem up


.PHONY: venv
venv:	## Setup a Virtual Environment
-	$(call Environment,./venv)


.PHONY: lint
lint: ## Lint the code
-	$(call Lint,./babble)


.PHONY: windows
windows: ## WIP: Install Windows dependencies
-	$(error This feature is not yet available.)
