#!/bin/bash

dotfiles::test_command_exists() {
  local command="$1"
  type "${command}" 2>&1 >/dev/null
}

if dotfiles::test_command_exists vim; then
  export EDITOR=vim
elif dotfiles::test_command_exists vi; then
  export EDITOR=vi
fi
