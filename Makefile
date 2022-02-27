SHELL := /usr/bin/env bash

EMACS ?= emacs
CASK ?= cask

PKG-FILES := buffer-menu-filter.el

TEST-FILES := $(shell ls test/buffer-menu-filter-*.el)

.PHONY: clean checkdoc lint build compile unix-test

ci: clean build compile

build:
	$(CASK) install

compile:
	@echo "Compiling..."
	@$(CASK) $(EMACS) -Q --batch \
		-L . \
		-l './bin/prepare.el' \
		-f batch-byte-compile $(PKG-FILES)

unix-test:
	@echo "Testing..."
	$(CASK) exec ert-runner -L . $(LOAD-TEST-FILES) -t '!no-win' -t '!org'

clean:
	rm -rf .cask *.elc
