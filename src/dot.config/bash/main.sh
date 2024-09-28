#!/bin/bash

_dotfiles__editor_list=("vim" "vi")

dotfiles::test_command_exists() {
  local command="$1"
  type "${command}" 2>&1 >/dev/null
}

dotfiles::configure_editor() {
  local editor

  for editor in ${_dotfiles__editor_list[@]}; do
    if dotfiles::test_command_exists "${editor}"; then
      export EDITOR="${editor}"
      break
    fi
  done
}

dotfiles::configure_editor
