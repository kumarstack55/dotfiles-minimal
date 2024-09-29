#!/bin/bash

bashrc_path="${HOME}/.bashrc"

# shellcheck disable=SC2016
hook_line='if [ -f "${HOME}/.config/bash/main.sh" ]; then . "${HOME}/.config/bash/main.sh"; fi'

err() {
  echo "$1" >&2
}

die() {
  err "died."
  exit 1
}

test_hook_line_exists() {
  grep -qF "${hook_line}" "${bashrc_path}"
}

copy_item_with_date() {
  local path="$1"
  local postfix

  postfix=$(date "+%F.%s") || die
  cp -iv "${path}" "${path}.${postfix}" || die
}

ensure_that_hook_line_exists() {
  if ! test_hook_line_exists; then
    copy_item_with_date "${bashrc_path}"
    (echo; echo "${hook_line}") >>"${bashrc_path}"
  fi
}

main() {
  ensure_that_hook_line_exists
}

main "$@"
