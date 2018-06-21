#!/bin/bash

# docker images
figlet() {
    docker run --rm -ti \
        mathieubrun/figlet:latest "$@"
}
export -f figlet

ganache_cli() {
    docker run --rm -ti \
        -p "8545:8545" \
        mathieubrun/ganache-cli:latest "$@"
}
export -f ganache_cli

gem() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        -v "${PWD}/.gems:/usr/local/bundle" \
        -p "4000:4000" \
        --entrypoint gem \
        mathieubrun/jekyll:latest "$@"
}
export -f gem

jekyll() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        -v "${PWD}/.gems:/usr/local/bundle" \
        -p "4000:4000" \
        mathieubrun/jekyll:latest "$@"
}
export -f jekyll

magick() {
    docker run --rm -ti \
    --workdir '/code' \
    -v "${PWD}:/code" \
    mathieubrun/magick:latest "$@"
}
export -f magick

npm() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        node:8.10.0-alpine npm $@
}
export -f npm

rsync() {
    docker run --rm -ti \
        --workdir /__work \
        -v "${HOME}/.ssh:/root/.ssh" \
        -v "$(pwd):/__work" \
        mathieubrun/rsync:latest $@
}
export -f rsync

truffle() {
    docker run --rm -ti \
        --workdir "/code" \
        -v "${PWD}:/code" \
        mathieubrun/truffle:latest "$@"
}
export -f truffle

webpack() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        node:8.10.0-alpine npx webpack $@
}
export -f webpack

yarn() {
    docker run --rm -ti \
        --workdir '/code' \
        -v "${PWD}:/code" \
        node:8.10.0-alpine yarn $@
}
export -f yarn
