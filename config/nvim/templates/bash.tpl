#!/usr/bin/env bash

o_option="default_value_option1"
o_help="0"
o_verbose="0"

verbose() {
  if [[ "$o_verbose" == "1" ]]; then
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    printf "[%s] %s\n" "${timestamp}" "${message}"
  fi
}

usage() {
    printf "usage: $0 [ -o option ] [ -h ] pos1 pos2
    -o:             option 1
    -h:             this help message
  pos1:             positional arg 1
  pos2:             positional arg 2
examples:

$0 -o %s pos1 pos2\n" "${o_option}"
}

PARSED_OPTIONS=$(getopt -n "$0" -o hvo: -- "$@")

if [[ $? -ne 0 ]]; then
    usage
fi

eval set -- "$PARSED_OPTIONS"

while true; do
  case "$1" in
    -o)
      o_option="$2"
      shift 2
      ;;
    -v)
      o_verbose="1"
      shift 1
      ;;
    -h)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      printf "unknown argument $1\n"
      usage
      exit 1
      ;;
  esac
done

if [[ $# -ne 2 ]]; then
    printf "pos1 and pos2 are mandatory\n"
    usage
    exit 1
fi

pos1="$1"
pos2="$2"

# some checks as exemple
# if [[ -z "${ENV_VAR}" ]]; then
#   printf "ENV_VAR environement variable is not set\n"
#   return
# fi
# 
# if [[ ! "${ENV_VAR}" =~ someregex ]]; then
#   printf "ENV_VAR must match 'someregex'\n"
#   return
# fi
