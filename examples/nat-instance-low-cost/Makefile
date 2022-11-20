SHELL := $(shell which bash) # set default shell

.DEFAULT: help # Running Make will run the help target
.PHONY: init plan apply destroy output clean


help: ## Show Help
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | \
    sort | \
    awk -F ':.*?## ' 'NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'

init:  ## init Terraform workflow in current directory
	terraform init

plan: init  ## calculate Terraform plan of what is going to be changed
	terraform plan -lock=false

apply: init ## apply changes 
	terraform apply -lock=false

destroy:  ## destroy all the resources created by applying Terraform plan
	terraform destroy -lock=false

output:  ## print the results of the module
	terraform output -json

clean:
	rm -rf *.pem; \
	rm -rf .terraform*; \
	rm -rf *.tfstate*; \
