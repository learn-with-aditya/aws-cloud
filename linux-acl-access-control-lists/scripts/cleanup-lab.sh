#!/usr/bin/env bash
set -euo pipefail
LAB_DIR="${HOME}/acl-practice-lab"
if [[ "$LAB_DIR" != "${HOME}/acl-practice-lab" ]]; then
  echo "Unexpected path; refusing cleanup."
  exit 1
fi
if [[ ! -d "$LAB_DIR" ]]; then
  echo "Nothing to clean up."
  exit 0
fi
echo "This permanently removes only: $LAB_DIR"
read -r -p 'Type DELETE-ACL-LAB to continue: ' answer
[[ "$answer" == "DELETE-ACL-LAB" ]] || { echo "Cancelled."; exit 1; }
rm -rf -- "$LAB_DIR"
echo "Removed $LAB_DIR"
