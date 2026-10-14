#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA="$ROOT/sample-data"
if [[ "$DATA" != */lab/sample-data ]]; then
  echo "Safety check failed; refusing to remove: $DATA" >&2
  exit 1
fi
rm -rf -- "$DATA"
echo "Removed lab/sample-data. Recreate it with: bash lab/setup-lab.sh"
