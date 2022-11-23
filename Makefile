#---------------------------
# Makefile
#---------------------------


SHELL := $(shell which bash) # set default shell

.DEFAULT: help # Running Make will run the help target

.PHONY: help
.PHONY: clean
.PHONY: sbx1


help: ## Show Help
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | \
    sort | \
    awk -F ':.*?## ' 'NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'


#-----------------------------------------
# Tools
#------------------------------------------

init: ## install tools
	asdf install







pre-commit-check: ## run all pre-commit checks
	cd . && \
	terraform init && \
	pre-commit run -a

clean: ## clean up cache directories
	find . -type d -name '.terragrunt-cache' | xargs rm -rf && \
	find . -type d -name '.terraform' | xargs rm -rf && \
	find . -type d -name '.terraform.lock.hcl' | xargs rm -rf && \
	find . -type d -name '.infracost' | xargs rm -rf
