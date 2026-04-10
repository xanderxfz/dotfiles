DOTFILE_PACKAGES = root ssh vscode opencode crush

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

.PHONY: homebrew
homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: dotfiles
dotfiles:
	stow --verbose --target ~ --restow $(DOTFILE_PACKAGES)
