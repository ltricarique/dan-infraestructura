#!/bin/bash

# This option causes the script to exit immediatly if
# an error is encountered.
set -o errexit

readonly REQUIRED_ENV_VARS=(
  "DAN_DB_USER"
  "DAN_DB_PASSWORD"
  "DAN_DB_NAME")

# Verify the environment vars are set.
verify_env_vars() {
  for evar in ${REQUIRED_ENV_VARS[@]}; do
    if [[ -z "${!evar}" ]]; then
      echo "Err: The env var '$evar' must be set."
      exit 1
    fi
  done
}

# Initalize
init_rdbms() {
  psql -c "CREATE ROLE $DAN_DB_USER WITH LOGIN PASSWORD '$DAN_DB_PASSWORD';"
  psql -c "CREATE DATABASE $DAN_DB_NAME WITH OWNER = $DAN_DB_USER ENCODING = 'UTF8' CONNECTION LIMIT = -1;"
  psql -U $DAN_DB_USER -d $DAN_DB_NAME -f dan-ms.dump;
}

main() {
  verify_env_vars
  init_rdbms
}

main "$@"