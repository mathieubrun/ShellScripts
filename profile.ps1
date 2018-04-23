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
        -v "${PWD}:/code" `
        -v "${PWD}\.gems:/usr/local/bundle" `
        -p "4000:4000" `
        mathieubrun/jekyll:latest $args
}

function figlet() {
    docker run --rm -ti `
        mathieubrun/figlet:latest $args
}