# ~/.zshrc

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi

# PATH
export PATH=$PATH:$HOME/.local/bin:$HOME/go/bin

# colors
c_yell='%F{yellow}'
c_reset='%f'
c_white='%F{white}'
c_cyan='%F{cyan}'
c_red='%F{red}'
c_blue='%F{blue}'
c_green='%F{green}'
c_magenta='%F{magenta}'
c_purple='%F{magenta}'

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt append_history
setopt share_history

# default editor
if command -v nvim >/dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vi
fi

# allow <C-s>/<C-q>
stty -ixon

# terminal
export TERM="xterm-256color"

# dynamic window title
autoload -Uz add-zsh-hook
function set-title() {
  print -Pn "\e]0;%n@%m:%~\a"
}
add-zsh-hook precmd set-title

# aliases
alias vi=nvim
alias y2j="python3 -c 'import sys, yaml, json; y=yaml.safe_load(sys.stdin.read()); print(json.dumps(y, indent=4))'"
alias j2y="python3 -c 'import sys, yaml, json; print(yaml.dump(json.loads(sys.stdin.read())))'"
alias jwt="jq -R 'split(\".\") | .[1] | @base64d | fromjson'"

# kubernetes
if command -v kubectl >/dev/null; then
  alias k=kubectl
  source <(kubectl completion zsh)
  export do='--dry-run=client -oyaml'
  command -v kubectx >/dev/null && alias kx=kubectx
  command -v kubens >/dev/null && alias ks=kubens
fi

# functions kubeon/kubeoff
kubeon() {
  if [[ -w ~/.config/starship.toml ]]; then
    tomcli-set ~/.config/starship.toml false kubernetes.disabled
    tomcli-set ~/.config/starship.toml del kubernetes.detect_folders
  fi
}
alias kon=kubeon

kubeoff() {
  if [[ -w ~/.config/starship.toml ]]; then
    tomcli-set ~/.config/starship.toml true kubernetes.disabled
    tomcli-set ~/.config/starship.toml list kubernetes.detect_folders 'vars'
  fi
}
alias koff=kubeoff

vaulton() {
  if [[ -w ~/.config/starship.toml ]]; then
    tomcli-set ~/.config/starship.toml false env_var.VAULT_ADDR.disabled
  fi
}
alias von=vaulton

vaultoff() {
  if [[ -w ~/.config/starship.toml ]]; then
    tomcli-set ~/.config/starship.toml true env_var.VAULT_ADDR.disabled
  fi
}
alias voff=vaultoff

# set environement variable from gpg file
e() {
  if [[ -f ~/.secrets.json.gpg ]]; then
    json=$(gpg --quiet --decrypt ~/.secrets.json.gpg 2>/dev/null)
    if [[ $# == 0 ]]; then
      env=$(jq -r '. | to_entries[] | .key' <<< "$json" | fzf)
      choice=$(jq -r --arg env "$env" '.[$env] | to_entries[] | .key' <<< "$json" | fzf)
      typeset -A vars
      eval "vars=($(jq -r --arg env $env --arg choice $choice '.[$env][$choice] | to_entries | .[] | .key + \"=\" + @sh .value' <<< "$json"))"
    else 
      keys=".$*"
      typeset -A vars
      eval "vars=($(jq -r "$keys | to_entries | .[] | .key + \"=\" + @sh .value" <<< "$json"))"
    fi
    for key value in "${(@kv)vars}"; do
      if [[ "$key" == "cmd" ]]; then
        eval "$value"
        echo "executed: $value" >&2
      else
        export "$key=$value"
        echo "environment set: $key" >&2
      fi
    done
  else
    echo "'~/.secrets.json.gpg' not found"
  fi
}

# zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# starship
command -v starship >/dev/null && eval "$(starship init zsh)"

# atuin
command -v atuin >/dev/null && eval "$(atuin init zsh --disable-up-arrow)"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude=.git "" $(git rev-parse --show-toplevel 2> /dev/null) |xargs realpath --relative-to=$(pwd)'

# nvim as man pager
export MANPAGER="nvim +Man!"

# gpg / ssh-agent
unset SSH_AGENT_PID
if [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

export RIPGREP_CONFIG_PATH=~/.ripgreprc
export TMUXP_CONFIGDIR=~/.config/tmuxp/

# ctrl-z → fg
if [[ -o interactive ]]; then
  stty susp undef
  bindkey '^Z' fg
fi

# run tmux
if [[ -z "$TMUX" ]]; then
  tmux
fi

setopt interactivecomments

# allow # as comment in terminal
setopt interactivecomments
# autofix typo
setopt correct
# Glob match hidden files
setopt globdots
# display error if glob does not match
setopt nomatch

# share hiostory between sessions
setopt share_history
# append to history
setopt append_history
# no doublon
setopt hist_ignore_dups
setopt hist_ignore_all_dups
# save duration and date
setopt extended_history

# Fichier d’historique
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# enable completion
autoload -Uz compinit && compinit
# color in completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# no beep
setopt no_beep
# easy navigation in completion menus
setopt auto_menu
# edit current line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
# make sure ctrl-a works
bindkey '^A' beginning-of-line
# make sure ctrl-e works
bindkey '^E' end-of-line
# esc + .
bindkey '^[.' insert-last-word
