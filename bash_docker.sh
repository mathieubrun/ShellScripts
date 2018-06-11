#!/bin/bash

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

rsync() {
    docker run --rm -ti \
        --workdir /__work \
        -v "${HOME}/.ssh:/root/.ssh" \
        -v "$(pwd):/__work" \
        mathieubrun/rsync:latest $@
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