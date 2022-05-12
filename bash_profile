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
export EDITOR=vim
export PS1="${c_cyan}\u@\h:${c_yell}\w ${c_reset}\$ "

# make <C-s> works in bash. Can also be achieved in PuTTY as well:
# Connection->SSH->TTY -> Mode -> IXION = 0
stty -ixon

case $TERM in
  xterm*|vte*)
    PROMPT_COMMAND='history -a; printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
  screen*)
    PROMPT_COMMAND='history -a; printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

# aliases
alias vi=vim
alias y2j="python3 -c 'import sys, yaml, json; y=yaml.load(sys.stdin.read(), Loader=yaml.FullLoader); print(json.dumps(y, indent=4))'"
alias jwt="jq -R 'split(\".\") | .[1] | @base64d | fromjson'"

# useful functions
function get-pem {
  openssl s_client -connect $1 2>/dev/null </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
}

if [ -z "$TMUX" ]; then
  tmux
fi

# bash command timer
# https://raw.githubusercontent.com/jichu4n/bash-command-timer/master/bash_command_timer.sh
if [ -e ~/.bash_command_timer.sh ] ; then
  source ~/.bash_command_timer.sh
  export BCT_TIME_FORMAT="%Y/%m/%d %H:%M:%S"
fi

# kubernetes
function get_cluster_short() {
  echo "$1" | cut -d @ -f2
}

if [ $(command -v kubectl) ]; then
  alias k=kubectl
  alias kaf='kubectl apply -f'
  source <(kubectl completion bash)
  complete -F __start_kubectl k
  export do='--dry-run=client -oyaml'
  if [ $(command -v kubectx) ]; then
    alias kx=kubectx
  fi
  if [ $(command -v kubens) ]; then
    alias kx=kubens
  fi
  # https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh
  if [ -f ~/.kube-ps1.sh ]; then
    source ~/.kube-ps1.sh
    KUBE_PS1_ENABLED=off
    export KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
    export KUBE_PS1_CTX_COLOR=green
    export KUBE_PS1_PREFIX="["
    export KUBE_PS1_SUFFIX="]"
    export KUBE_PS1_SYMBOL_ENABLE=false
    export KUBE_PS1_CTX_COLOR=magenta
    export KUBE_PS1_NS_COLOR=green
    export PS1="${c_cyan}\u@\h:${c_yell}\w ${c_reset}\$(kube_ps1)\$ "
  fi
fi

# local config
if [ -f ~/.bash_local ]; then
  source ~/.bash_local
fi
