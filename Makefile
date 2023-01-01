#!/usr/bin/make -f
# -*- makefile -*-

SHELL         := /bin/bash
.SHELLFLAGS   := -eu -o pipefail -c
.DEFAULT_GOAL := help

.ONESHELL:             ;   # Recipes execute in same shell
.NOTPARALLEL:          ;   # Wait for this target to finish
.SILENT:               ; 	 # No need for @
.EXPORT_ALL_VARIABLES: ;   # Export variables to child processes.
.DELETE_ON_ERROR:      ;   # Delete target if recipe fails.

# MAKEFLAGS += --warn-undefined-variables # DEBUGGING
# MAKEFLAGS += --no-builtin-rules         # DEBUGGING

# Modify the block character to be `-\t` instead of `\t`
ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = -

ifeq ($(OS),Windows_NT)
SHELL := powershell.exe
.SHELLFLAGS := -NoProfile -Command
.DEFAULT_GOAL := windows
endif


define Lint
	echo -e "🐍 \033[36mLinting project code...\033[0m"
	python3 -m black $1
endef


default: $(.DEFAULT_GOAL)
all: help

.PHONY: help
help: ## List commands
-	@echo -e "USAGE: make \033[36m[COMMAND]\033[0m\n"
-	@echo "Available commands:"
-	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\t\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


PHONY: update
update: ## git pull branch
-	echo -e "\033[36mUpdating branch...\033[0m"
-	git pull origin `git config --get remote.origin.url`


PHONY: model-server
model-server: ## Host a model server on localhost:9000
-	echo -e "\033[36mUpdating branch...\033[0m"
-	docker compose up babble


PHONY: test-siem
test-siem: ## Launch a test SIEM on localhost:8000
-	echo -e "\033[36mUpdating branch...\033[0m"
-	docker compose --profile test-siem up


.PHONY: venv
venv:	## WIP: Setup a Virtual Environment
-	echo -e "\033[36mSetting up virtual environment...\033[0m"


.PHONY: lint
lint: ## Lint the code
-	$(call Lint,./babble)


##
# WIP: Windows support
#   For Windows users, you can use the following command to run this Makefile:
#     $ choco install make
#     $ make -f Makefile
.PHONY: windows
windows: ## WIP: Windows
-	echo "Work in Progress..."
-	echo "Check back soon!"
