# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/go/bin
export PATH

c_yell='\[\e[00;33m\]'
c_reset='\[\e[0m\]'
c_white='\[\e[00;37m\]'
c_cyan='\[\e[00;36m\]'
c_red='\[\e[00;31m\]'
c_blue='\[\e[00;34m\]'
c_green='\[\e[00;32m\]'
c_magenta='\[\e[00;95m\]'
c_purple='\[\e[00;35m\]'

# bash settings
export HISTSIZE=-1
export HISTTIMEFORMAT="[%Y/%m/%d %T]"
export PROMPT_DIRTRIM=2
export HISTCONTROL=ignorespace
export EDITOR=nvim
export PS1="${c_cyan}\u@\h:${c_yell}\w ${c_reset}\$ "

# make <C-s> works in bash. Can also be achieved in PuTTY as well:
# Connection->SSH->TTY -> Mode -> IXION = 0
stty -ixon
HOSTNAME=$(hostname -s)
export TERM="xterm-256color"
case $TERM in
  xterm*|vte*)
    PROMPT_COMMAND='history -a; printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
  screen*)
    PROMPT_COMMAND='history -a; printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
esac

# aliases
alias vi=nvim
alias y2j="python3 -c 'import sys, yaml, json; y=yaml.load(sys.stdin.read(), Loader=yaml.FullLoader); print(json.dumps(y, indent=4))'"
alias j2y="python3 -c 'import sys, yaml, json; print(yaml.dump(json.loads(sys.stdin.read())))'"
alias jwt="jq -R 'split(\".\") | .[1] | @base64d | fromjson'"

# useful functions
function get-pem {
  openssl s_client -connect $1 2>/dev/null </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
}

function checkgit {
  rc=0
  [ -z "${1}"] && local current=$(git rev-parse --abbrev-ref HEAD) || local current="${1}"
  [ -z "${2}"] && local upsteam=$(git rev-parse --abbrev-ref --symbolic-full-name @{u}) || local upsteam="${2}"
  local ancestor=$(git merge-base "${current}" "${upsteam}")
  local aref=$(git rev-parse "${current}")
  local bref=$(git rev-parse "${upsteam}")
  local 
  if [[ "${aref}" == "${bref}" ]]; then
    echo "git status is clean"
  elif [[  "${aref}" = "${ancestor}" ]]; then
    echo "git is behind"
  elif [[  "${bref}" = "${ancestor}" ]]; then
    echo "git is ahead"
    rc=1
  else
    echo "git diverge"
    rc=1
  fi
  if [[ $(git status --porcelain) ]]; then
    echo "git local change(s)"
    rc=1
  fi
}

# bash command timer
# curl -o .bash_command_timer.sh https://raw.githubusercontent.com/jichu4n/bash-command-timer/master/bash_command_timer.sh
#if [ -e ~/.bash_command_timer.sh ] ; then
#  source ~/.bash_command_timer.sh
#  export BCT_TIME_FORMAT="%Y/%m/%d %H:%M:%S"
#fi

# kubernetes
if [ $(command -v kubectl) ]; then
  alias k=kubectl
  if [ ! $(command -v kaf) ]; then
    alias kaf='kubectl apply -f'
  fi
  source <(kubectl completion bash)
  complete -F __start_kubectl k
  export do='--dry-run=client -oyaml'
  if [ $(command -v kubectx) ]; then
    alias kx=kubectx
  fi
  if [ $(command -v kubens) ]; then
    alias ks=kubens
  fi
fi

function kubeon() {
  if [[ -w ~/.config/starship.toml ]]; then
    # requires tomcli package
    tomcli-set ~/.config/starship.toml false kubernetes.disabled
    tomcli-set ~/.config/starship.toml del kubernetes.detect_folders
  fi
}

function kubeoff() {
  if [[ -w ~/.config/starship.toml ]]; then
    # requires tomcli package
    tomcli-set ~/.config/starship.toml true kubernetes.disabled
    tomcli-set ~/.config/starship.toml list kubernetes.detect_folders 'vars'
  fi
}

# deal with environments
function e() {
  if [ -f ~/.secrets.json.gpg ]; then
    json=$(gpg --quiet --decrypt ~/.secrets.json.gpg &1> /dev/null)
    if [[ $# == 0 ]]; then
      env=$(jq -r '. | to_entries[] | .key' <<< "$json" | fzf)
      choice=$(jq -r --arg env "$env" '. | to_entries[] | select(.key==$env) | .value | to_entries[] | .key' <<< $json | fzf)
    elif [[ $# == 1 ]]; then
      env=$1
      choice=$(jq -r --arg env "$env" '. | to_entries[] | select(.key==$env) | .value | to_entries[] | .key' <<< $json | fzf)
    else
      env=$1
      choice=$2
    fi
    declare -A vars="($(jq -r --arg env $env --arg choice $choice '.[$env][$choice] | to_entries[] | "[" + .key + "]=" + "\"" + .value +"\""' <<< "$json"))"
    local executed=""
    for key in "${!vars[@]}"
    do
      if [ "$key" == "cmd" ]; then
        $(${vars[$key]})
        executed="${vars[$key]}"
      else
        export "$key=${vars[$key]}"
      fi
    done
  else
    printf "'~/.secrets.json.gpg' not found\n"
  fi
  printf "environment set: %s/%s" "${env}" "${choice}"
  if [ ! -z "$executed" ]; then
    printf " (cmd: %s)" "${executed}"
  fi
  printf "\n"
}

# zoxide
if [ $(command -v zoxide) ]; then
  eval "$(zoxide init bash)"
fi

# starship
if [ $(command -v starship) ]; then
  eval "$(starship init bash)"
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude=.git "" $(git rev-parse --show-toplevel 2> /dev/null) |xargs realpath --relative-to=$(pwd)'

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

export GPG_TTY=`tty`
gpg-connect-agent updatestartuptty /bye >/dev/null

export RIPGREP_CONFIG_PATH=~/.ripgreprc
export TMUX_BROWSER="/mnt/c/Program Files/Mozilla Firefox/firefox.exe"

export TMUXP_CONFIGDIR=~/.config/tmuxp/
# local config
if [ -f ~/.bash_local ]; then
   source ~/.bash_local
fi

# secret config
#if [ -f ~/.bash_secret.gpg ]; then
#   source <(gpg --quiet --decrypt ~/.bash_secret.gpg)
#fi

# start tmux after loading all environement variables
if [ -z "$TMUX" ]; then
  tmux
fi
