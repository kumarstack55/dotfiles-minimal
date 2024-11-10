#!/bin/bash

_dotfiles__editor_list=("nvim" "vim" "vi")

dotfiles::err() {
  echo "$*" >&2
}

dotfiles::warn() {
  dotfiles::err "Warning: $*"
}

# Check if a command exists
dotfiles::test_command_exists() {
  local command="$1"
  type "${command}" >/dev/null 2>&1
}

# Configure the editor
dotfiles::configure_editor() {
  local editor

  for editor in "${_dotfiles__editor_list[@]}"; do
    if dotfiles::test_command_exists "${editor}"; then
      export EDITOR="${editor}"
      break
    fi
  done
}

# Add $HOME/bin to $PATH if it is not already there
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

# Configure local settings
dotfiles::configure_local() {
  local script_dir local_dir sh_path

  script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
  local_dir="${script_dir}/local"

  if [[ ! -d "${local_dir}" ]]; then
    return
  fi

  # env.sh の場所を変更すべきであることを示す。
  if [[ -e "${script_dir}/env.sh" ]]; then
    dotfiles::warn "Please move env.sh to local/env.sh"
  fi

  for sh_path in "${local_dir}"/*.sh; do
    if [[ -f "${sh_path}" ]]; then
      # shellcheck disable=SC1090
      . "${sh_path}"
    fi
  done
}

dotfiles::main() {
  dotfiles::configure_editor
  dotfiles::configure_path
  dotfiles::configure_local
}

dotfiles::main "$@"
