#!/usr/bin/make -f
# -*- makefile -*-

SHELL         := /bin/bash
.SHELLFLAGS   := -eu -o pipefail -c
.DEFAULT_GOAL := help

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
# SHELL := powershell.exe
# .SHELLFLAGS := -NoProfile -Command
# .DEFAULT_GOAL := windows
$(error WIP: Windows support is not yet available.)
endif


define Lint
	echo -e "🧼 \033[36mLinting project code...\033[0m"
	python3 -m black $1
endef


define Environment
	echo -e "🐍 \033[36mSetting up virtual environment...\033[0m"
	if [ ! -d "$1" ]; then
 		echo -e "🐍 \033[36mInstalling Python virtual environment package...\033[0m"
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
-	echo -e "USAGE: make \033[36m[COMMAND]\033[0m\n"
-	echo "Available commands:"
-	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\t\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


PHONY: update
update: ## git pull branch
-	echo -e "🆕 \033[36mUpdating branch...\033[0m"
-	git pull origin `git config --get remote.origin.url`


PHONY: model-server
model-server: ## Host a model server on localhost:9000
-	echo -e "🫧 \033[36mUpdating branch...\033[0m"
-	docker compose up babble


PHONY: test-siem
test-siem: ## Launch a test SIEM on localhost:8000
-	echo -e "🌐 \033[36mUpdating branch...\033[0m"
-	docker compose --profile test-siem up


.PHONY: venv
venv:	## Setup a Virtual Environment
-	$(call Environment,./venv)


.PHONY: lint
lint: ## Lint the code
-	$(call Lint,./babble)

