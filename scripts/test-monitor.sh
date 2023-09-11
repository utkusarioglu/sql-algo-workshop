#!/bin/bash

COLOR_RED="\e[31m"
COLOR_GREEN="\e[32m"
COLOR_NONE="\e[0m"

PY_EXTENSION="py"
UNIT_TEST_SUFFIX="unit_test"

file_class="$UNIT_TEST_SUFFIX.$PY_EXTENSION"

function log_error_no_param_abspath {
  echo -e "${COLOR_RED}Error:${COLOR_NONE} First param needs to be a valid test or implementation py file path"
}

function log_error_no_implementation_abspath {
  echo -e "${COLOR_RED}Error:${COLOR_NONE} Cannot find the implementation file"
}

function log_error_no_test_abspath {
  echo -e "${COLOR_RED}Error:${COLOR_NONE} Cannot find the test file"
}

function log_info_starting_watchmedo {
  echo -e "${COLOR_GREEN}Starting Watchmedo${COLOR_NONE} for '${implementation_basename}'…"
}

function main {
  param_abspath=$1

  if [ -z "$param_abspath" ]; then
    log_error_no_param_abspath
    exit 1
  fi

  param_relpath=${param_abspath/$(pwd)\//}
  param_basename=$(basename $param_relpath)
  param_filename=${param_basename%.*}
  param_dir_abspath=${param_abspath/\/$param_basename/}

  implementation_filename="${param_filename/_${UNIT_TEST_SUFFIX}/}"
  implementation_basename="$implementation_filename.$PY_EXTENSION"
  implementation_abspath="$param_dir_abspath/$implementation_basename"

  test_filename="${implementation_filename}_$UNIT_TEST_SUFFIX"
  test_basename="$test_filename.$PY_EXTENSION"
  test_abspath="$param_dir_abspath/$test_basename"

  if [ ! -f "$implementation_abspath" ]; then
    log_error_no_implementation_abspath
    exit 2
  fi

  if [ ! -f  "$test_abspath" ]; then
    log_error_no_test_abspath
    exit 3
  fi

  log_info_starting_watchmedo

  watchmedo shell-command \
    --patterns "$test_abspath;$implementation_abspath" \
    --recursive \
    --wait \
    --verbose \
    --command '
        if [ "${watch_event_type}" = "closed" ]; then
          pytest '$test_abspath'
        fi
      '\
    "$param_dir_abspath"
}

main $@
