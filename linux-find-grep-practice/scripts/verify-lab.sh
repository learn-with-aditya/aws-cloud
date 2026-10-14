#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA="$ROOT/lab/sample-data"
if [[ ! -d "$DATA" ]]; then
  echo "Lab data not found. Run: bash lab/setup-lab.sh" >&2
  exit 1
fi
for f in app.log access.log error.log users.txt services.conf status.txt empty.txt nested/worker.log nested/archive/old.log config/nginx.conf; do
  [[ -f "$DATA/$f" ]] || { echo "Missing: $f" >&2; exit 1; }
done
grep -q 'ERROR' "$DATA/app.log"
find "$DATA" -type f -name '*.log' | grep -q .
echo "PASS: required sample files exist; find and grep checks succeeded."
