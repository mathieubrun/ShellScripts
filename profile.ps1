if ((Test-Path "C:\Program Files\Docker Toolbox\docker-machine.exe")) {
    & "C:\Program Files\Docker Toolbox\docker-machine.exe" env --shell powershell | Invoke-Expression
}

# git aliases
function glog { git log --oneline --graph }

# docker aliases
function dps { docker ps $args }
function dl { docker logs $args }
function dk { docker kill $args }
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

function dotnet-add-analysis() {
    dotnet add package Microsoft.CodeAnalysis.FxCopAnalyzers
    dotnet add package StyleCop.Analyzers
    dotnet add package Roslynator.Analyzers
    dotnet add package SonarAnalyzer.Csharp
}