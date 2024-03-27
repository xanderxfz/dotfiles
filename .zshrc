export ZSH="$HOME/.oh-my-zsh"


ZSH_THEME="gentoo"

plugins=(git sudo docker kubectl helm terraform golang brew)

source $ZSH/oh-my-zsh.sh


# Prevent Homebrew from reporting
export HOMEBREW_NO_ANALYTICS=1

# More clean history
setopt histignoredups histignorespace
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS


# Stash your environment variables in ~/.zshenv
if [[ -a ~/.zshenv ]]; then
  source ~/.zshenv
fi


export PATH="/usr/local/sbin:$PATH"

# GoLang
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin/:$GOPATH/bin

# Java and Groovy
export JAVA_HOME=/usr/local/Cellar/openjdk/21.0.2
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export PATH=$PATH:$JAVA_HOME/bin:$GROOVY_HOME
