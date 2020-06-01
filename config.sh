#!/usr/bin/env bash
# 2019-05, Bruno Grossniklaus, https://github.com/it-gro

function hive_cli {
  if [ -n "${JDBC_HIVE2_URL}" ]; then
    beeline -n "${USER}" -u "${JDBC_HIVE2_URL}" "$@"
  else
    hive "$@"
  fi
}

export ts_ext=/warehouse/tablespace/external/hive