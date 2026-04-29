export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export TERM=xterm-256color

# Prevent Homebrew from reporting
export HOMEBREW_NO_ANALYTICS=1


# GoLang
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin/:$GOPATH/bin

# Rancher
export PATH="$HOME/.rd/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# OpenCode
export PATH=$HOME/.opencode/bin:$PATH
. "$HOME/.cargo/env"

export KUBECONFIG=~/.kube/config

export PATH="$HOME/bin/:$HOME/.local/bin/:$HOME/.npm/bin:/usr/local/sbin:$PATH"

. "$HOME/.local/bin/env"
