#!/bin/bash

_dotfiles__editor_list=("nvim", "vim" "vi")

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

dotfiles::configure_path() {
  local -a path_array
  local home_bin_dir="$HOME/bin"
  local found= p

  if [[ ! -d "${home_bin_dir}" ]]; then
    return
  fi

  IFS=":" read -r -a path_array <<<"$PATH"
  for p in "${path_array[@]}"; do
    if [[ "${p}" == "${home_bin_dir}" ]]; then
      found=y
      break
    fi
  done

  if [[ "${found}" ]]; then
    PATH="${home_bin_dir}:${PATH}"
  fi
}

dotfiles::configure_vim_features() {
  export DOTFILES_VIM_GITHUB_COPILOT=n
}

dotfiles::main() {
  dotfiles::configure_editor
  dotfiles::configure_path
}

dotfiles::main "$@"
