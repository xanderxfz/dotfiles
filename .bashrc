# Color setup
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
MAGENTA="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
BOLD="\[\033[1m\]"
RESET="\[\033[0m\]"

# Function to get current git branch
parse_git_branch() {
  git branch --show-current 2>/dev/null
}

# Function to get git status symbol
git_status_symbol() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  local status=""
  if ! git diff --quiet 2>/dev/null; then
    status="${status}${RED}✗"
  fi
  if ! git diff --cached --quiet 2>/dev/null; then
    status="${status}${YELLOW}+"
  fi
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    status="${status}${MAGENTA}?"
  fi
  if [ -z "$status" ]; then
    status="${GREEN}✔"
  fi
  echo -e "$status${RESET}"
}

# Combine all parts into the PS1 prompt
set_bash_prompt() {
  local git_branch="$(parse_git_branch)"
  if [ -n "$git_branch" ]; then
    local git_status="$(git_status_symbol)"
    git_branch=" ${CYAN}(${git_branch})${git_status}"
  fi
  local base_ps1="${BOLD}${GREEN}\u@\h${RESET} ${YELLOW}\w${RESET}${git_branch}"

  # Append prompt symbol depending on user type
  if [ "$EUID" -ne 0 ]; then
    PS1="${base_ps1} \$ "
  else
    PS1="${base_ps1} # "
  fi
}

PROMPT_COMMAND=set_bash_prompt
