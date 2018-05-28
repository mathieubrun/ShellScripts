#!/bin/sh

export SHELL_SCRIPTS_PATH=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

alias ls='LC_COLLATE=C ls --group-directories-first --color'

# mac os specific
if [[ "$OSTYPE" == "darwin"* ]]; then

    # vs code
    VS_CODE_DIR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    if [ -e "$VS_CODE_DIR" ]; then
        export PATH="$PATH:$VS_CODE_DIR"
    fi

    # ls
    alias ls='LC_COLLATE=C gls --group-directories-first --color'
fi

export LS_COLORS="di=36:ln=35:so=31;1;44:pi=30;1;44:ex=1;31:bd=0;1;44:cd=37;1;44:su=37;1;41:sg=30;1;43:tw=30;1;42:ow=30;1;43"

# bash aliases
alias ll='ls -l -h'
alias lla='ll -a'
alias ..='cd ..'

# git
alias glog='git log --oneline --graph'
alias gstatus='git status --porcelain'

gclone() {
    if [ $# -eq 2 ]; then
        git clone https://github.com/$1/$2 ~/github/$1/$2 && cd ~/github/$1/$2
    fi
}

## prompt
function __git_changes() {
    local __changes=$(git status 2> /dev/null --porcelain)

    if [ -n "$__changes" ]; then
        local __A=$(echo "$__changes" | awk '/^ A/ {print $2}' | wc -l | awk '{print $1}')
        local __D=$(echo "$__changes" | awk '/^ D/ {print $2}' | wc -l | awk '{print $1}')
        local __M=$(echo "$__changes" | awk '/^ M/ {print $2}' | wc -l | awk '{print $1}')
        local __U=$(echo "$__changes" | awk '/\?\?/ {print $2}' | wc -l | awk '{print $1}')

        if [ $__A -ne "0" ]; then
            echo -n $" +$__A"
        fi
        if [ $__D -ne "0" ]; then
            echo -n $" -$__D"
        fi
        if [ $__M -ne "0" ]; then
            echo -n $" !$__M"
        fi
        if [ $__U -ne "0" ]; then
            echo -n $" ?$__U"
        fi
    fi
}

function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    [ -n "$__CONTAINER_NAME" ]; local __docker="\[\033[01;32m\]$__CONTAINER_NAME"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\\\\\1\/`'
    local __git_changes='`__git_changes`'
    local __newline="\n"
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__docker $__user_and_host $__cur_location $__git_branch_color$__git_branch$__git_changes$__newline$__prompt_tail$__last_color "
}

color_my_prompt

# docker
alias dps='docker ps'
alias dl='docker logs'
alias dk='docker kill'
alias dprune='docker system prune --all --force'

dbuild() {
    docker build -t mathieubrun/${PWD##*/}:latest .
}

dbash() {
    docker run --rm -ti -v "$SHELL_SCRIPTS_PATH/bash_profile.sh:/__scripts/bash_profile.sh" --env __CONTAINER_NAME="$1" --entrypoint bash $1 --rcfile /__scripts/bash_profile.sh
}

# dotnet
dotnet-add-analysis() {
    dotnet add package Microsoft.CodeAnalysis.FxCopAnalyzers
    dotnet add package StyleCop.Analyzers
    dotnet add package Roslynator.Analyzers
    dotnet add package SonarAnalyzer.Csharp
}

# docker images
figlet() {
    docker run --rm -ti \
        mathieubrun/figlet:latest "$@"
}

ganache-cli() {
    docker run --rm -ti \
        -p "8545:8545" \
        mathieubrun/ganache-cli:latest "$@"
}

gem() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        -v "${PWD}/.gems:/usr/local/bundle" \
        -p "4000:4000" \
        --entrypoint gem \
        mathieubrun/jekyll:latest "$@"
}

jekyll() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        -v "${PWD}/.gems:/usr/local/bundle" \
        -p "4000:4000" \
        mathieubrun/jekyll:latest "$@"
}

magick() {
    docker run --rm -ti \
    --workdir '/code' \
    -v "${PWD}:/code" \
    mathieubrun/magick:latest "$@"
}

npm() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        node:8.10.0-alpine npm $@
}

truffle() {
    docker run --rm -ti \
        --workdir "/code" \
        -v "${PWD}:/code" \
        mathieubrun/truffle:latest "$@"
}

webpack() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        node:8.10.0-alpine npx webpack $@
}

yarn() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        node:8.10.0-alpine yarn $@
}