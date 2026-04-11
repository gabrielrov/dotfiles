[[ -f "$HOME/.zsh_env" ]] && source "$HOME/.zsh_env"

# ~~~~~~~~~~ options ~~~~~~~~~~
PS1="%{%F{cyan}%}%~ %{%F{blue}%}❯%{%f%} "
PROMPT_EOL_MARK="" # suffix mark for when typing before loading

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"

bindkey -e # emacs keys

autoload -U colors && colors # exposes color vars to zsh
command -v dircolors &> /dev/null && eval "$(dircolors -b)" # sets LS_COLOR values (used on completion)

zmodload zsh/complist # more completion features

WORDCHARS=${WORDCHARS/\/} # c-w will not delete entire path

# -- history --
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

setopt appendhistory # appends to history instead of overwriting
setopt sharehistory # share history between sessions
setopt hist_ignore_space # don't save when prefixed with space (useful for sensisitive commands)
setopt hist_ignore_dups hist_save_no_dups hist_find_no_dups # don't save duplicate commands

# -- bindings --
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line # alt+e or esc+e

# -- completion --
bindkey -M menuselect '^[[Z' reverse-menu-complete # S-Tab binding for consistency
bindkey -M menuselect '\r' .accept-line # send command without confirming selection

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # case insensitive completions
zstyle ':completion:*' menu select # tab focuses cmp menu
zstyle ':completion:*' special-dirs true # includes '.' and '..' on completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 'ma=0\;38\;2\;247\;64\;140' # colorize cmp menu

# ~~~~~~~~~~ aliases ~~~~~~~~~~
boilerplate() {
  local folder="${1:-main}"
  cp -r ~/boilerplate/"$folder"/{*,.*} . 2>/dev/null
}

alias ls='ls --color=auto'
alias l='ls --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -alF --color=auto'

t() {
  if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach &> /dev/null || (command -v sesh &> /dev/null && sesh connect "$(sesh list | fzf)")
  fi
}

alias nv='nvim'
alias lz='lazygit'
alias cd='z'
alias nodei='node --inspect'
alias nodew='node --watch'
alias nodeiw='node --inspect --watch'

# ~~~~~~~~~~ plugin manager ~~~~~~~~~~
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

unalias zi
# ~~~~~~~~~~ plugins ~~~~~~~~~~
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab

# -- zsh-history-substring-search --
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_PREFIXED=true # Only exact prefix match
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='' # Case sensisitive

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''

# -- fzf-tab --
zstyle ':completion:*' menu no # Disable default completion
zstyle ':fzf-tab:*' use-fzf-default-opts yes # Mirror config for fzf
zstyle ':fzf-tab:*' continuous-trigger 'ctrl-l' # Follow paths
zstyle ':fzf-tab:*' switch-group 'f1' 'f2'

smart-tab() { [[ -z ${BUFFER//[[:space:]]/} ]] || zle fzf-tab-complete }
zle -N smart-tab
bindkey '^I' smart-tab # tab will not have effect on empty lines

# ~~~~~~~~~~ shell integrations ~~~~~~~~~~
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# -- fzf --
# ctrl-t, ctrl-r and alt-c binded automatically

export FZF_DEFAULT_OPTS="
  --bind 'ctrl-j:accept'
  --bind 'ctrl-space:toggle'
  --bind 'tab:down'
  --bind 'shift-tab:up'
  --bind 'ctrl-d:ignore'
  --bind 'ctrl-k:ignore'
  --bind 'ctrl-l:ignore'
"

export PATH=/home/gabs/.opencode/bin:$PATH

[ -z "$TMUX" ] && t
