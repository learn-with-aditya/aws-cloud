#!/usr/bin/env bash
set -euo pipefail
LAB_DIR="${HOME}/acl-practice-lab"
if [[ ! -d "$LAB_DIR" ]]; then
  echo "Not found: $LAB_DIR. Run ./scripts/setup-lab.sh first."
  exit 1
fi
echo "== Files =="
find "$LAB_DIR" -maxdepth 3 -printf '%M %u %g %p\n'
echo
echo "== ACLs =="
getfacl -R "$LAB_DIR"
