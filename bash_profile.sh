#!/bin/bash

shopt -s no_empty_cmd_completion

export SHELL_SCRIPTS_PATH=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

alias ls='LC_COLLATE=C ls --group-directories-first --color'

# windows specific
if [ "$OSTYPE" == "msys" ]; then

    if [ -n "$(type -t docker)" ] && [ "$(type -t docker)" = file ]; then
        docker() {
            MSYS_NO_PATHCONV=1 docker.exe "$@"
        }
        export -f docker
    fi
fi

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
    if [ $# -eq 1 ]; then
        cd ~/github
        git clone https://github.com/$1 && cd ~/github/$1
    fi
}

## prompt

function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    [ -n "$__CONTAINER_NAME" ]; local __docker="\[\033[01;32m\]$__CONTAINER_NAME"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git symbolic-ref --short HEAD 2>/dev/null`'
    local __newline="\n"
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__docker $__user_and_host $__cur_location $__git_branch_color$__git_branch$__newline$__prompt_tail$__last_color "
}

color_my_prompt

# docker
alias dps='docker ps'
alias dl='docker logs'
alias dk='docker kill'

dprune() {
    docker system prune --force --all
    docker network prune --force 
    docker volume prune --force
}

dbuild() {
    docker build -t mathieubrun/${PWD##*/}:latest .
}

dbash() {
    docker run --rm -ti -v "$SHELL_SCRIPTS_PATH/bash_profile.sh:/__scripts/bash_profile.sh" --env __CONTAINER_NAME="$1" --entrypoint bash $1 --rcfile /__scripts/bash_profile.sh
}

# dotnet
dotnet_add_analysis() {
    dotnet add package Microsoft.CodeAnalysis.FxCopAnalyzers
    dotnet add package StyleCop.Analyzers
    dotnet add package Roslynator.Analyzers
    dotnet add package SonarAnalyzer.Csharp
}

if [ -f "$SHELL_SCRIPTS_PATH/bash_docker.sh" ]; then
    source "$SHELL_SCRIPTS_PATH/bash_docker.sh"
fi

if [ -f "$SHELL_SCRIPTS_PATH/bash_pi.sh" ]; then
    source "$SHELL_SCRIPTS_PATH/bash_pi.sh"
fi