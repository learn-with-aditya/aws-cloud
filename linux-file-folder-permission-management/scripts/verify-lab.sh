#!/usr/bin/env bash
set -euo pipefail
LAB_DIR="/tmp/linux-permission-lab"
if [[ ! -d "$LAB_DIR" ]]; then
  echo "Not found: $LAB_DIR. Run ./scripts/setup-lab.sh first."
  exit 1
fi
ls -la "$LAB_DIR"
echo
stat -c '%A %a %U %G %n' "$LAB_DIR" "$LAB_DIR/notes.txt" "$LAB_DIR/hello.sh" "$LAB_DIR/sample-dir"
echo
id
