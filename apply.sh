#!/bin/bash

set -eu

DOTFILES_PATH=$(cd $(dirname $0); pwd)

for f in .??*; do
    [[ $f == ".git" ]] && continue
    [[ $f == ".ssh" ]] && continue
    [[ $f == ".gitignore" ]] && continue

    ln -sfnv $DOTFILES_PATH/$f ~/$f
done

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
