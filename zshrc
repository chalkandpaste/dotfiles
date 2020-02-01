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

export PATH=$HOME/miniconda3/bin:/home/chalkandpaste/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
