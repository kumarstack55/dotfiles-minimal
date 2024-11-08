#!/bin/bash

_dotfiles__editor_list=("nvim" "vim" "vi")

dotfiles::test_command_exists() {
  local command="$1"
  type "${command}" >/dev/null 2>&1
}

dotfiles::configure_editor() {
  local editor

  for editor in "${_dotfiles__editor_list[@]}"; do
    if dotfiles::test_command_exists "${editor}"; then
      export EDITOR="${editor}"
      break
    fi
  done
}

dotfiles::configure_path() {
  local -a path_array
  local home_bin_dir="$HOME/bin"
  local found=
  local p

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

  if [[ ! "${found}" ]]; then
    PATH="${home_bin_dir}:${PATH}"
  fi
}

dotfiles::configure_vim_features() {
  local script_dir env_sh_path

  script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
  env_sh_path="${script_dir}/env.sh"

  # shellcheck source=./env.sh
  . "${env_sh_path}"
}

dotfiles::main() {
  dotfiles::configure_editor
  dotfiles::configure_path
  dotfiles::configure_vim_features
}

dotfiles::main "$@"
