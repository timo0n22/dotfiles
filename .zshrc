PROMPT='%1~ %# '
export PATH=$PATH:$(go env GOPATH)/bin
export LC_ALL=en_US.UTF-8

export TERM=xterm-256color
eval "$(gdircolors -b | sed 's/DIR 01;34/DIR 01;38;5;69/')"

export LSCOLORS="ExGxFxdaCxDaDahbadacec"
export CLICOLOR=1

alias n="nvim ."

# Created by `pipx` on 2025-05-13 16:36:47
export PATH="$PATH:/Users/artemloginov/.local/bin"
