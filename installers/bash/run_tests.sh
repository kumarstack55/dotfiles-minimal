#!/bin/bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# shellcheck disable=SC2164
cd "${script_dir}/.."

exit_status=0

tests_dir="./tests"

for dsl_path in "${tests_dir}"/*.dsl; do
  echo "## test: ${dsl_path}"
  basename=$(basename "${dsl_path}" .dsl)
  expect_path="${tests_dir}/${basename}.txt"

  if ! actual=$(set -x; ./bash/install.sh -c -e TEST_DUMMY_KEY=test_dummy_value "${dsl_path}"); then
    echo "fail - It failed to run ${dsl_path}"
    exit_status=1
    continue
  fi

  if diff_output=$(diff -u <(echo "${actual}") "${expect_path}"); then
    echo "ok"
  else
    echo "fail - The result differs as expected."
    echo "${diff_output}"
    exit_status=1
  fi
  echo
done

exit "${exit_status}"