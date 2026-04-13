# Stash your environment variables in ~/.zshenv
if [[ -a ~/.zshenv ]]; then
  source ~/.zshenv
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gentoo"

plugins=(git sudo docker kubectl helm terraform golang brew)
autoload -Uz compinit && compinit

source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/docker/docker.plugin.zsh 2>/dev/null || true

# More clean history
setopt hist_ignore_all_dups
setopt histignoredups histignorespace
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

alias tma="tmux a"
alias tml="tmux list-sessions"
alias dc="docker compose"
alias tf="terraform"
alias k="kubectl"
alias eks="eksctl"
alias python="python3"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
