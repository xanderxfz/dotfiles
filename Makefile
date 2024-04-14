
.PHONY: default
default: ansible

.PHONY: install-ansible
install-ansible:
	python3 -m pip install --user ansible

.PHONY: sh
sh:
	./apply.sh

.PHONY: ansible
ansible:
	ansible-playbook playbooks/main.yml -i hosts
