# ansible_project
Repository for a ansible project. The meaning of the project is to automatize creating and controlling unlimited amount of computers with the following tools:
- Terraform: Making x amount of cloud computers from a chosen service. For this project we've chosen Upcloud. The terraform template used in this procets was taken from one of their example [repositorys](https://github.com/UpCloudLtd/upcloud-ansible-collection/blob/main/examples/inventory-rolling-update/resources/main.tf) 
- Ansible: Automate configuring/controlling the chosen computers made with Terraform. You can also only use the  Ansible part for existing computer(s).


## TODO
- Dokumentaatio miten käyttää, mitä tekee, mitä käyttäjän pitää tehdä manuaalisesti.
- Läpi esitys/demo kellotus kauan menee ja miten tehdään.
- Varmuuden vuoks demo video?! 

## What is inside this repo?
-`install_initial.sh` a shell script which installs the prequisites for running terraform and ansible. It runs the following:
	- Installs python3 pip and ansible from apt
	- Installs upcloud api from pip3 (without venv)
	- Installs other dependencies, gnupg, coreutils which are for terraform
	- And curl+ssh for ssh into the computers
	- And then it installs the dependencies for installing terraform, the bash commands are directly from hashicorps site https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli 
	- And finally it installs terraform

- Ansible folder
	- All you have to do to control the computers you already have or just made with terraform you just need to insert their ip's to hosts.ini

Resources used:
- https://upcloud.com/docs/guides/get-started-ansible-inventory/
- https://upcloud.com/docs/guides/rolling-update-terraform-ansible/
- https://github.com/UpCloudLtd/upcloud-ansible-collection
	- From here we've used and modifed the terraform template/examples/inventory-rolling-update/resources/main.tf https://github.com/UpCloudLtd/upcloud-ansible-collection/blob/main/examples/inventory-rolling-update/resources/main.tf
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Report's from earlier homeworks
