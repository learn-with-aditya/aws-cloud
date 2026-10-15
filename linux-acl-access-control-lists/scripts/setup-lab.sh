#!/usr/bin/env bash
set -euo pipefail
LAB_DIR="${HOME}/acl-practice-lab"
if [[ -e "$LAB_DIR" ]]; then
  echo "Already exists: $LAB_DIR"
  echo "Inspect it first; refusing to overwrite."
  exit 1
fi
mkdir -m 700 "$LAB_DIR"
printf 'ACL practice report\n' > "$LAB_DIR/report.txt"
mkdir "$LAB_DIR/shared"
printf 'Shared training note\n' > "$LAB_DIR/shared/note.txt"
echo "Created $LAB_DIR"
echo "No users or groups were created or modified."
