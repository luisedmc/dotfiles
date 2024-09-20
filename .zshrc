fastfetch

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

# Aliases
alias ls="exa --icons --group-directories-first"
alias ll="exa --long --header"
alias lsd="exa --icons --group-directories-first -1"
alias cat="bat"
