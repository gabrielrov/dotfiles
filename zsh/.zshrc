# Instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ -f "$HOME/.zsh_env" ]] && source "$HOME/.zsh_env"

# ~~~~~~~~~~ Options ~~~~~~~~~~
PROMPT_EOL_MARK="" # Suffix mark for when typing before loading

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"

autoload -U colors && colors # Exposes color vars to zsh
command -v dircolors &> /dev/null && eval "$(dircolors -b)" # Sets LS_COLOR values (used on completion)

zmodload zsh/complist # More completion features

WORDCHARS=${WORDCHARS/\/} # C-w will not delete entire path

# -- History --
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

setopt appendhistory # Appends to history instead of overwriting
setopt sharehistory # Share history between sessions
setopt hist_ignore_space # Don't save when prefixed with space (useful for sensisitive commands)
setopt hist_ignore_dups hist_save_no_dups hist_find_no_dups # Don't save duplicate commands

# -- Completion --
bindkey -M menuselect '^[[Z' reverse-menu-complete # S-Tab binding for consistency
bindkey -M menuselect '\r' .accept-line # Send command without confirming selection

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Case insensitive completions
zstyle ':completion:*' menu select # Tab focuses cmp menu
zstyle ':completion:*' special-dirs true # Includes '.' and '..' on completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 'ma=0\;38\;2\;247\;64\;140' # Colorize cmp menu

# ~~~~~~~~~~ Aliases ~~~~~~~~~~
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
    tmux attach &> /dev/null || sesh connect "$(sesh list | fzf)"
  fi
}

alias nv='nvim'
alias lz='lazygit'
alias cd='z'
alias nodei='node --inspect'
alias nodew='node --watch'
alias nodeiw='node --inspect --watch'

# ~~~~~~~~~~ Plugin manager ~~~~~~~~~~
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

unalias zi
# ~~~~~~~~~~ Plugins ~~~~~~~~~~
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab

# -- powerlevel10k --
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
bindkey '^I' smart-tab # Tab will not have effect on empty lines

# ~~~~~~~~~~ Shell integrations ~~~~~~~~~~
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
