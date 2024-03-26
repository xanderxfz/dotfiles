#!/bin/bash

set -eu

DOTFILES_PATH=$(cd $(dirname $0); pwd)

for f in .??*; do
    [[ $f == ".git" ]] && continue
    [[ $f == ".gitignore" ]] && continue

    ln -sfnv $DOTFILES_PATH/$f ~/$f
done
