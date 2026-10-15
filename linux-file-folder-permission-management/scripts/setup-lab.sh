#!/usr/bin/env bash
set -euo pipefail
LAB_DIR="/tmp/linux-permission-lab"
if [[ -e "$LAB_DIR" ]]; then
  echo "Already exists: $LAB_DIR"
  echo "Inspect it first; refusing to overwrite."
  exit 1
fi
mkdir -m 700 "$LAB_DIR"
printf 'Linux permissions practice file.\n' > "$LAB_DIR/notes.txt"
printf '#!/usr/bin/env bash\necho "Hello from the lab script"\n' > "$LAB_DIR/hello.sh"
mkdir "$LAB_DIR/sample-dir"
printf 'Sample content.\n' > "$LAB_DIR/sample-dir/example.txt"
echo "Created $LAB_DIR. No system users or groups were created."
