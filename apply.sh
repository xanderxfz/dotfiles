#!/usr/bin/env bash

set -eu

DOTFILES_PATH=$(cd $(dirname $0); pwd)

install_pkgs() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! dpkg -s "$pkg" >/dev/null 2>&1; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -gt 0 ]; then
    echo "🔧 Installing missing packages: ${to_install[*]}"
    sudo apt install -y "${to_install[@]}"
  fi
}


install_pkgs less zsh git mc curl wget tmux jq

# Install tmux tpm if it's missed
TPM_PATH=~/.tmux/plugins/tpm
[[ ! -d $TPM_PATH ]] && git clone https://github.com/tmux-plugins/tpm $TPM_PATH


# Install oh-my-zsh
OH_MY_ZSH_PATH=~/.oh-my-zsh
[[ ! -d $OH_MY_ZSH_PATH ]] && sh -c "$(curl -fsSL https://install.ohmyz.sh/)"

# Install zsh-syntax-highlighting
ZSH_SYNTAX_HIGHLIGHTING_PATH=~/.zsh/zsh-syntax-highlighting
[[ ! -d $ZSH_SYNTAX_HIGHLIGHTING_PATH ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_SYNTAX_HIGHLIGHTING_PATH


# Install zsh-autosuggestions
ZSH_AUTOSUGGESTIONS_PATH=~/.zsh/zsh-autosuggestions
[[ ! -d $ZSH_AUTOSUGGESTIONS_PATH ]] && git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_AUTOSUGGESTIONS_PATH
