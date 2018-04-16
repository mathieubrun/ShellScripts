#/bin/bash

jekyll() {
    docker run -ti \
        --workdir '/code' \
        -v "$(pwd):/code" \
        -v "$(pwd)/.gems:/usr/local/bundle" \
        -p "4000:4000" \
        mathieubrun/jekyll:latest
}