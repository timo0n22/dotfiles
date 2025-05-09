PROMPT='%1~ %# '
export PATH=$PATH:$(go env GOPATH)/bin

export TERM=xterm-256color
eval "$(gdircolors -b | sed 's/DIR 01;34/DIR 01;38;5;69/')"

export LSCOLORS="ExGxFxdaCxDaDahbadacec"  # Стиль Kanagawa-подобных цветов
export CLICOLOR=1  # Включить цветной вывод
