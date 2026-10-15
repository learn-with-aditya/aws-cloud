#!/usr/bin/env bash
set -euo pipefail
LAB_DIR="/tmp/linux-permission-lab"
if [[ "$LAB_DIR" != "/tmp/linux-permission-lab" ]]; then
  echo "Unexpected path; refusing cleanup."
  exit 1
fi
if [[ ! -d "$LAB_DIR" ]]; then
  echo "Nothing to clean up."
  exit 0
fi
echo "This permanently removes only $LAB_DIR"
read -r -p 'Type DELETE-LAB to continue: ' answer
[[ "$answer" == "DELETE-LAB" ]] || { echo "Cancelled."; exit 1; }
rm -rf -- "$LAB_DIR"
echo "Removed $LAB_DIR"
