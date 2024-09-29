#!/bin/bash

declare -A g_env
declare g_line g_line_pos g_char g_eof
declare g_string_buffer
declare -a g_stack

declare option_check_mode=y

app::write_usage_exit() {
  echo "Usage: $ ./installer.sh [OPTIONS...] script.dsl"
  echo
  echo "Options:"
  echo "-c           : Check mode. Skip all executions. (default)"
  echo "-e KEY=VALUE : Override variables."
  echo "-f           : Disable check mode."
  echo "-h           : Print this message."
  exit 1
}

helper::should_process() {
  if [[ "$option_check_mode" ]]; then
    echo "should_process: $1"
  fi

  [[ ! "$option_check_mode" ]]
}

helper::test_function_exists() {
  local function_name="$1" _ f found=''

  while read -r _ _ f; do
    if [[ "${function_name}" == "${f}" ]]; then
      found=y
      break
    fi
  done < <(declare -F)

  [[ "${found}" ]]
}

io::write_err() {
  echo "${1:-}" >&2
}

# shellcheck disable=SC2120
throw::die() {
  local msg="${1:-Died}"
  local fi="${2:-1}"
  local li=$((fi-1))
  local lineno="${BASH_LINENO[${li}]}"
  local at="${BASH_SOURCE[${fi}]} line ${lineno}"
  io::write_err "${msg} at ${at}."
  exit 1
}

throw::die_syntax_error() {
  local fi="${2:-2}"

  reader::print_syntax_error
  throw::die "Syntax error: ${1:-}" "${fi}"
}

throw::die_syntax_error_eof() {
  throw::die_syntax_error "Unexpected EOF found" 3
}

# shellcheck disable=SC2120
throw::die_internal_error() {
  throw::die "Internal error: ${1:-}" 2
}

string_buffer::init() {
  g_string_buffer=''
}

string_buffer::add() {
  g_string_buffer="${g_string_buffer}$1"
}

string_buffer::get() {
  echo "${g_string_buffer}"
}

env::init() {
  g_env[HOME]="${HOME}"

  # The linux installer does not support a PROFILE variable.
  # Therefore, it evaluates it as an empty string.
  g_env[PROFILE]=""
}

env::set() {
  local key="$1" value="$2"
  g_env["${key}"]="${value}"
}

env::test_key() {
  local key="$1"
  [[ "${g_env[${key}]+x}" ]]
}

env::get() {
  local key="$1"
  echo "${g_env[${key}]}"
}

command::write_skip_reason_path_alread_exists() {
  echo "skip. (reason: path already exists)"
}

command::write_skip_reason_platform_is_different() {
  echo "skip. (reason: platform is different)"
}

command::write_diff() {
  local file1="$1" file2="$2"
  diff -u --color=always "${file1}" "${file2}"
}

command::command_copy() {
  local command="$1" src="$2" dest="$3"

  if helper::should_process "${command} ${src} ${dest}"; then
    if [[ -e "${dest}" ]]; then
      command::write_skip_reason_path_alread_exists
      command::write_diff "${src}" "${dest}"
      return
    fi
    cp -v "${src}" "${dest}"
  fi
}

command::command_copy_linux() {
  local command="$1" src="$2" dest="$3"

  if helper::should_process "${command} ${src} ${dest}"; then
    if [[ -e "${dest}" ]]; then
      command::write_skip_reason_path_alread_exists
      command::write_diff "${src}" "${dest}"
      return
    fi
    cp -v "${src}" "${dest}"
  fi
}

command::command_copy_win() {
  local command="$1" src="$2" dest="$3"

  if helper::should_process "${command} ${src} ${dest}"; then
    command::write_skip_reason_platform_is_different
  fi
}

command::command_debug_var() {
  local command="$1" name="$2"
  local value

  value=$(env::get "${name}")
  echo "debug_var: ${name}=${value}"
}

command::command_join_path() {
  local command="$1" name="$2" value="$3"

  shift 3
  for path_part in "$@"; do
    value="${value}/${path_part}"
  done

  env::set "${name}" "${value}"
}

command::command_mkdir() {
  local command="$1" path="$2"

  if helper::should_process "${command} ${path}"; then
    if [[ -e "${path}" ]]; then
      command::write_skip_reason_path_alread_exists
      return
    fi
    mkdir -p -v "${path}"
  fi
}

command::command_mkdir_linux() {
  command::command_mkdir "$@"
}

command::command_mkdir_win() {
  local command="$1" path="$2"

  if helper::should_process "${command} ${path}"; then
    command::write_skip_reason_platform_is_different
  fi
}

command::command_set() {
  local command="$1" name="$2" value="$3"

  env::set "${name}" "${value}"
}

command::command_set_linux() {
  local command="$1" name="$2" value="$3"

  env::set "${name}" "${value}"
}

command::command_set_win() {
  local command="$1" name="$2" value="$3"

  command::write_skip_reason_platform_is_different
}

command::test_exists() {
  local function_name="$1" command_func

  command_func="command::command_${function_name}"
  helper::test_function_exists "${command_func}"
}

command::run() {
  local function_name="$1"

  command_func="command::command_${function_name}"
  echo "run:" "$@"
  "${command_func}" "$@"
}

reader::init() {
  local line="$1"

  g_line="${line}"
  g_line_pos=-1
  g_char=''
  g_eof=''
}

reader::is_eof() {
  [[ "$g_eof" ]]
}

reader::is_not_eof() {
  ! reader::is_eof
}

reader::read_next() {
  local IFS

  if reader::is_not_eof; then
    if IFS= read -r -n1 g_char; then
      # When there was no input, read did not return non-zero and
      # assigned the value "" to the variable.
      # This behavior differs from the read specification, but is
      # tlreated here as end-of-file for convenience.
      # https://www.gnu.org/software/bash/manual/bash.html#index-read
      if [[ "${g_char}" == '' ]]; then
        g_eof=y
      fi
    else
      g_eof=y
    fi

    g_line_pos=$((g_line_pos+1))
  fi
}

reader::read_char() {
  echo "${g_char}"
}

reader::print_syntax_error() {
  local index=0

  echo    "input: [${g_line}]"
  echo -n "        "
  while ((index < g_line_pos)); do
    echo -n " "
    index=$((index+1))
  done
  echo "^"
}

parser::init() {
  g_stack=()
}

parser::is_space() {
  [[ $1 == ' ' ]]
}

parser::is_function_character() {
  [[ $1 =~ ^[[:alnum:]_]$ ]]
}

parser::skip_ws0() {
  while reader::is_not_eof; do
    if ! parser::is_space "$(reader::read_char)"; then
      break
    fi
    reader::read_next
  done
}

parser::skip_ws1() {
  if parser::is_space "$(reader::read_char)"; then
    parser::skip_ws0
  else
    throw::die_syntax_error "blank space required"
  fi
}

parser::parse_comment() {
  while reader::is_not_eof; do
    reader::read_next
  done
}

parser::parse_function() {
  local name=''

  while reader::is_not_eof; do
    if parser::is_function_character "$(reader::read_char)"; then
      name="${name}$(reader::read_char)"
      reader::read_next
    else
      if [[ "${name}" == '' ]]; then
        throw::die_syntax_error "Function name is zero-length string"
      fi
      g_stack+=("${name}")
      return
    fi
  done

  if [[ "${name}" == '' ]]; then
    throw::die_syntax_error "Function name is zero-length string"
  fi
  g_stack+=("${name}")
}

parser::parse_escape() {
  if [[ "$(reader::read_char)" != "\\" ]]; then
    # shellcheck disable=SC2119
    throw::die_internal_error
  fi

  reader::read_next
  if reader::is_eof; then
    # shellcheck disable=SC2119
    throw::die_syntax_error
  fi

  if [[ "$(reader::read_char)" == '"' ]]; then
    string_buffer::add '"'
    reader::read_next
  elif [[ "$(reader::read_char)" == "\\" ]]; then
    string_buffer::add "\\"
    reader::read_next
  elif [[ "$(reader::read_char)" == '$' ]]; then
    string_buffer::add '$'
    reader::read_next
  else
    # shellcheck disable=SC2119
    throw::die_syntax_error "Invalid escape [$(reader::read_char)]"
  fi
}

parser::parse_variable() {
  local name=''

  if [[ "$(reader::read_char)" != '$' ]]; then
    # shellcheck disable=SC2119
    throw::die_internal_error
  fi

  reader::read_next
  if reader::is_eof; then
    throw::die_syntax_error_eof
  fi

  if [[ "$(reader::read_char)" != '{' ]]; then
    # shellcheck disable=SC2119
    throw::die_syntax_error "Character [{] does not exist"
  fi

  reader::read_next
  while reader::is_not_eof; do
    if [[ "$(reader::read_char)" == '}' ]]; then
      reader::read_next

      if ! env::test_key "${name}"; then
        throw::die_syntax_error "Unknown variable name: [${name}]"
      fi
      string_buffer::add "$(env::get "${name}")"

      return
    else
      name="${name}$(reader::read_char)"
      reader::read_next
    fi
  done

  # shellcheck disable=SC2119
  throw::die_syntax_error_eof
}

parser::parse_string_characters() {
  while reader::is_not_eof; do
    if [[ "$(reader::read_char)" == '"' ]]; then
      return
    elif [[ "$(reader::read_char)" == "\\" ]]; then
      parser::parse_escape
    elif [[ "$(reader::read_char)" == '$' ]]; then
      parser::parse_variable
    else
      string_buffer::add "$(reader::read_char)"
      reader::read_next
    fi
  done

  # shellcheck disable=SC2119
  throw::die_syntax_error_eof
}

parser::parse_string() {
  if [[ "$(reader::read_char)" != '"' ]]; then
    # shellcheck disable=SC2119
    throw::die
  fi

  reader::read_next
  if reader::is_eof; then
    # shellcheck disable=SC2119
    throw::die
  fi

  string_buffer::init
  parser::parse_string_characters
  if [[ $(reader::read_char) != '"' ]]; then
    # shellcheck disable=SC2119
    throw::die
  fi

  reader::read_next

  g_stack+=("$(string_buffer::get)")
}

parser::parse_argument() {
  parser::parse_string
}

parser::parse_arguments() {
  parser::parse_argument
  if reader::is_eof; then
    return
  fi

  parser::skip_ws1
  if reader::is_eof; then
    return
  fi

  parser::parse_arguments
}

parser::parse_command() {
  local command_func function_name

  parser::parse_function

  function_name="${g_stack[0]}"
  if ! command::test_exists "${function_name}"; then
    throw::die_syntax_error "Unknown function: [${function_name}]"
  fi

  if reader::is_not_eof; then
    parser::skip_ws1
    if reader::is_not_eof; then
      parser::parse_arguments
    fi
  fi

  command::run "${g_stack[@]}"
}

parser::parse_line() {
  if reader::is_eof; then
    return
  fi

  if [[ "$(reader::read_char)" == "#" ]]; then
    parser::parse_comment
  else
    parser::parse_command
  fi
}

parser::parse_program() {
  reader::read_next

  parser::skip_ws0
  parser::parse_line
  parser::skip_ws0
}

main() {
  local option line key value

  env::init

  while getopts "ce:fh" option; do
    case ${option} in
      c) option_check_mode=y;;
      e)
        IFS="=" read -r key value <<<"${OPTARG}"
        env::set "${key}" "${value}"
        ;;
      f) option_check_mode=;;
      h) app::write_usage_exit;;
      \?) app::write_usage_exit;;
    esac
  done
  shift $((OPTIND-1))

  if [[ $# != 1 ]]; then
    app::write_usage_exit
  fi
  script_path="$1"

  while IFS= read -r line || [[ "${line}" ]]; do
    # At least, when reading a line ending in crlf in a Windows MING64
    # environment, there is a cr at the end of $line. For convenience,
    # remove the cr here.
    line="${line//$'\r'}"

    echo "---"
    reader::init "${line}"
    echo "line: [${line}]"
    parser::init
    parser::parse_program <<<"${line}"
  done <"${script_path}"
}

main "$@"
