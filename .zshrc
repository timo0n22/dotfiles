# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

PROMPT='%1~ %# '
export PATH=$PATH:$(go env GOPATH)/bin
export LC_ALL=en_US.UTF-8

export TERM=tmux-256color
eval "$(gdircolors -b | sed 's/DIR 01;34/DIR 01;38;5;69/')"

export LSCOLORS="ExGxFxdaCxDaDahbadacec"
export CLICOLOR=1
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='fg=#dcd7ba'
ZSH_HIGHLIGHT_STYLES[command]='fg=#7e9cd8'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#c0a36e'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#957fb8'
ZSH_HIGHLIGHT_STYLES[path]='fg=#98bb6c'

alias n="nvim ."
alias f="fzf --preview 'bat --style=numbers --color=always {}'"

# Created by `pipx` on 2025-05-13 16:36:47
export PATH="$PATH:/Users/artemloginov/.local/bin"

if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  mkdir -p ~/.zinit && git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

# plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/artemloginov/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
