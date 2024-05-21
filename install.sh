#!/bin/bash

die() {
  echo "die: $1"
  exit 1
}

skip() {
  echo "skip: $1"
}

skip_not_windows() {
  skip "$1 (reason: not windows)"
}

module_copy() {
  local src="$1" dest="$2"

  if [[ ! -e "${dest}" ]]; then
    cp -v "${src}" "${dest}"
  else
    skip "copy ${src} ${dest}"
  fi
}

module_copy_win() {
  skip_not_windows "copy $*"
}

module_mkdir_win() {
  skip_not_windows "mkdir_win $*"
}

parse_line() {
  local line="$1" module
  local -a words

  read -a words -r <<<"${line}"

  for i in "${!words[@]}"; do
    words[$i]="${words[$i]//\$\{HOME\}/$HOME}"
  done

  set -- "${words[@]}"

  module="$1"
  shift

  case "${module}" in
    "copy") module_copy "$@";;
    "copy_win") module_copy_win "$@";;
    "mkdir_win") module_mkdir_win "$@";;
    *) die "unknown module: ${module}";;
  esac
}

parse_playbook() {
  local playbook_path="$1"
  local module words

  while read -r line; do
    if [[ "${line}" =~ ^#|^[[:space:]]*$ ]]; then
      continue
    fi
    parse_line "${line}"
  done <"${playbook_path}"
}

echo_script_dir() {
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd
}

main() {
  local script_dir=$(echo_script_dir)
  local playbook_path="${script_dir}/playbook.dsl"

  cd "$dir"
  parse_playbook "${playbook_path}"
}

main "$@"
# vim:ts=2 sw=2 sts=2 et:
