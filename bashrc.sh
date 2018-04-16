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

dbuild() {
    docker build -t mathieubrun/${PWD##*/}:latest .
}

jekyll() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        -v "${PWD}/.gems:/usr/local/bundle" \
        -p "4000:4000" \
        mathieubrun/jekyll:latest "$@"
}

figlet() {
    docker run --rm -ti \
        mathieubrun/figlet:latest "$@"
}