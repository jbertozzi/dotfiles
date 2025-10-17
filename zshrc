setopt autocd # no need to type cd
setopt extendedglob #advanced glob
setopt nomatch # no error if no match
setopt share_history # real time history sharing
setopt append_history # add commands to history
setopt hist_ignore_dups # ignore consecutive duplicated commands
setopt hist_ignore_all_dups # ignore all duplicated commands
setopt extended_history # add date and time to history

# load completion and prompt internal scripts
autoload -Uz compinit promptinit
compinit
promptinit

# emacs key binding (bash default)
bindkey -e

# interactive menu
zstyle ':completion:*' menu select

# zinit
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
    mkdir -p ~/.zinit/bin
    git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# ctrl-k / ctrl-j to start completion and navigate
zmodload zsh/complist
bindkey '^J' down-or-complete
bindkey '^K' up-or-complete

bindkey -M menuselect '^J' down-line-or-history
bindkey -M menuselect '^K' up-line-or-history

# history, without atuin
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# kubernetes
if command -v kubectl >/dev/null; then
  source <(kubectl completion zsh)
  export do='--dry-run=client -oyaml'
  command -v kubectx >/dev/null && alias kx=kubectx
  command -v kubens >/dev/null && alias ks=kubens
fi

# gpg / ssh-agent
unset SSH_AGENT_PID
if [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# some export
export RIPGREP_CONFIG_PATH=~/.ripgreprc
export TMUXP_CONFIGDIR=~/.config/tmuxp/
export MANPAGER="nvim +Man!"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude=.git "" $(git rev-parse --show-toplevel 2> /dev/null) |xargs realpath --relative-to=$(pwd)'

# starship
command -v starship >/dev/null && eval "$(starship init zsh)"
# atuin
eval "$(atuin init zsh --disable-up-arrow)"
# zoxide
eval "$(zoxide init zsh)"

# custom aliases and functions
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions

