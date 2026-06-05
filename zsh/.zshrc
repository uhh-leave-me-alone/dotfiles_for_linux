# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="half-life"

# === LIST OF THEMES THAT ARE GOOD FOR VIM MODE AND GIT WORK ===
# half-life, aussiegeek, ys, crcandy , dstufft

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

plugins=(vi-mode git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-history-substring-search)

export KEYTIMEOUT=10                           # почти мгновенная реакция на jj
bindkey -M viins 'jj' vi-cmd-mode              # выход из insert mode по jj

source $ZSH/oh-my-zsh.sh

# Vi-mode 
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true  # промпт меняется при смене режима
VI_MODE_SET_CURSOR=true  # курсор меняет форму: блок в normal, черта в insert

# === FZF SECTION BEGIN. Must be written only after source oh-my-zsh === 
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --info=inline
  --highlight-line
"

export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window 'down:3:wrap'
  --scheme=history
  --bind 'ctrl-r:toggle-sort'
"

export FZF_CTRL_T_OPTS="
  --preview 'batcat --color=always --line-range :50 {} 2>/dev/null || cat {}'
  --preview-window 'right:50%'
"

export FZF_ALT_C_OPTS="
  --preview 'ls --color=always {}'
"

if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi
# ↑↑↑ FZF SECTION END ↑↑↑

# === BINDINGS FOR HISTORY STRING SUBSEARCH BEGIN === 

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# === BINDINGS FOR HISTORY STRING SUBSEARCH END === 

#TURN ON IF YOU WANT TO RUN THE AUTOCOMPLETION PLUGIN AGAIN (USER ADDED)
#zstyle ':autocomplete:*' list-lines 5
#bindkey '^I' menu-select

#===ALIAS SECTION BEGIN===
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias vi='nvim'
alias cat='batcat'
alias mullvad='~/Downloads/mullvad-browser/Browser/mullvadbrowser --proxy-server="http://127.0.0.1:12334"'
alias icat='kitty +kitten icat'
alias mc='sudo ip link set dev wlp2s0 down && sudo macchanger -r wlp2s0 && sudo ip link set dev wlp2s0 up && sudo ip link show'
alias telegram-vpn='proxychains4 ~/Downloads/Telegram/Telegram'
alias xrandr='xrandr && echo "THIS IS NOT HOW YOU CHANGE YOUR MONITOR MODE IN SWAY (if you are using sway btw). USE swaymsg -t get_outputs instead". If you are using hyprland then type in "hyprctl monitors"'
#===ALIAS SECTION END===

export PATH=~/.npm-global/bin:$PATH
export PATH=~/.local/bin/lua-language-server/bin:$PATH

export EDITOR=nvim
export VISUAL=nvim
