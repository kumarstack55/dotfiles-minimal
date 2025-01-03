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

# Check if a path is in $PATH
dotfiles::test_path_in_env_path() {
  local target="$1"
  local -a path_array
  local p

  IFS=":" read -r -a path_array <<<"$PATH"
  for p in "${path_array[@]}"; do
    if [[ "${p}" == "${target}" ]]; then
      return 0
    fi
  done
  return 1
}

# Configure the PATH
dotfiles::configure_path() {
  local -a path_list=("$HOME/bin" "$HOME/.local/bin")
  local p

  for p in "${path_list[@]}"; do
    if [[ ! -d "${p}" ]]; then
      continue
    fi

    if ! dotfiles::test_path_in_env_path "${p}"; then
      # WSL など、Windows の PATH が含まれている場合がある。
      # より優先すべきパスであることが支配的であるため、先頭に追加する。
      PATH="${p}:${PATH}"
    fi
  done
}

# Configure completion
dotfiles::configure_completion() {
  if type kubectl >/dev/null 2>&1; then
    # shellcheck disable=SC1090
    source <(kubectl completion bash)
  fi

  if type oc >/dev/null 2>&1; then
    # shellcheck disable=SC1090
    source <(oc completion bash)
  fi

  if type aws_completer >/dev/null 2>&1; then
    complete -C '/usr/local/bin/aws_completer' aws
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
  dotfiles::configure_completion
  dotfiles::configure_local
}

dotfiles::main "$@"
