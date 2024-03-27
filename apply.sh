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
