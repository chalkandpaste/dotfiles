#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias vim=nvim
alias vi=nvim

autoload -Uz promptinit
promptinit
prompt paradox

export NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim
export HOMEBREW_GITHUB_API_TOKEN=""

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/miniconda3/bin:$PATH
