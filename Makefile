#!/usr/bin/make -f
# -*- makefile -*-

SHELL         := /bin/bash
.SHELLFLAGS   := -eu -o pipefail -c
.DEFAULT_GOAL := help
.LOGGING      := 0

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


PROJECT_DIR := $(shell pwd)
SRC_DIR     := $(PROJECT_DIR)/src
BUILD_DIR   := $(PROJECT_DIR)/build


ifeq ($(OS),Windows_NT)
SHELL := powershell.exe
.SHELLFLAGS := -NoProfile -Command
.DEFAULT_GOAL := windows
.LOGGING :=
$(warning WIP: Windows support is not yet available.)
endif


define Logging
	if [[ $(.LOGGING) -eq 1 ]]; then
		mkdir -p `dirname $1`
		exec 1> >(tee -a $1) 2>&1
	fi
endef


define Lint
	echo "🧼 Linting project code..."
	python3 -m black $1
endef


define Environment
	echo "🐍 Setting up virtual environment..."
	if [ ! -d "$1" ]; then
 		echo "🐍 Installing Python virtual environment package..."
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
-	$(call Logging,./logs/$(shell date +%Y-%m-%d-%H-%M-%S).log)
-	echo -e "USAGE: make \033[36m[COMMAND]\033[0m\n"
-	echo "Available commands:"
-	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\t\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


PHONY: update
update: ## git pull branch
-	$(call Logging,./logs/$(shell date +%Y-%m-%d-%H-%M-%S).log)
-	echo "🆕 Updating branch..."
-	git pull origin `git config --get remote.origin.url`


.PHONY: run
run: ## Run babble
-	babble


.PHONY: venv
venv:	## Setup a Virtual Environment
-	$(call Logging,./logs/$(shell date +%Y-%m-%d-%H-%M-%S).log)
-	$(call Environment,./venv)


PHONY: model-server
model-server: ## Host a model server on localhost:9000
-	$(call Logging,./logs/$(shell date +%Y-%m-%d-%H-%M-%S).log)
-	echo "🫧 Launching babble server..."
-	docker compose up babble


## TODO: Zeek preprocessing
# chmod +x tools/bin/zeek.process.sh
# ./tools/bin/zeek.process.sh


PHONY: test-siem
test-siem: ## Launch a test SIEM on localhost:8000
-	$(call Logging,./logs/$(shell date +%Y-%m-%d-%H-%M-%S).log)
-	echo "🌐 Launching SIEM..."
-	docker compose --profile test-siem up


.PHONY: lint
lint: clean ## Lint the code
-	$(call Logging,./logs/$(shell date +%Y-%m-%d-%H-%M-%S).log)
-	$(call Lint,./babble)


.PHONY: clean
clean: ## Remove build, test, coverage and Python artifacts
-	rm -rf ./logs


.PHONY: windows
windows: ## WIP: Install Windows dependencies
-	$(error This feature is not yet available.)


.PHONY: container-env
container-env: ## Babble installer for docker-compose
-	python3 -m pip install --upgrade pip
-	python3 -m pip install -e .
