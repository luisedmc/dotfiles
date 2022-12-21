export ZSH="$HOME/.oh-my-zsh"

neofetch

# Auto Startx
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

# Plugins
plugins=(
  archlinux
  zsh-autosuggestions
  zsh-syntax-highlighting
  esc/conda-zsh-completion
)

ZSH_THEME="gentoo"

source $ZSH/oh-my-zsh.sh
