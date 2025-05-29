eval (/opt/homebrew/bin/brew shellenv)
starship init fish | source
set -x NVM_DIR $HOME/.nvm
zoxide init fish | source
alias cd="z"
alias vim="nvim"
alias tm="tmuxinator"
