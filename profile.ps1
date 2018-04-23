# git aliases
function glog { git log --oneline --graph }

# docker aliases
function dps { docker ps }
function dl { docker logs }
function dk { docker kill }
function dprune { docker system prune --all --force }

function jekyll() {
    docker run --rm -ti `
        --workdir '/code' `
        -v "${pwd}:/code" `
        -v "${pwd}\.gems:/usr/local/bundle" `
        -p "4000:4000" `
        mathieubrun/jekyll:latest $args
}

function figlet() {
    docker run --rm -ti `
        mathieubrun/figlet:latest $args
}

function truffle() {
    docker run --rm -ti `
        --workdir "/code" `
        -v "${pwd}:/code" `
        mathieubrun/truffle:latest $args
}

function ganache-cli() {
    docker run --rm -ti `
        -p "8545:8545" `
        mathieubrun/ganache-cli:latest $args
}

function npm() {
    docker run --rm -ti `
        --workdir '/code' `
        -v "${pwd}:/code" `
        node:8.10.0-alpine npm $args
}