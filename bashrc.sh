#/bin/bash

. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts/z.sh"

# misc
if [[ "$OSTYPE" == "darwin"* ]]; then
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
fi

alias ll='ls -l'
alias lla='ls -al'
alias ..='cd ..'

# git aliases
alias glog='git log --oneline --graph'

# docker aliases
alias dps='docker ps'
alias dl='docker logs'
alias dk='docker kill'
alias dprune='docker system prune --all --force'