#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA="$ROOT/sample-data"
mkdir -p "$DATA/nested/archive" "$DATA/config" "$DATA/tmp"

cat > "$DATA/app.log" <<'EOF'
2026-10-14 09:00:01 INFO Application starting
2026-10-14 09:00:02 INFO Configuration loaded
2026-10-14 09:00:05 WARN Cache response is slow
2026-10-14 09:02:14 ERROR Payment service timeout
2026-10-14 09:02:15 INFO Retrying payment request
2026-10-14 09:02:18 ERROR Database connection refused
2026-10-14 09:02:20 WARN Retry limit nearly reached
2026-10-14 09:03:00 INFO Health check completed
EOF

cat > "$DATA/access.log" <<'EOF'
10.0.0.5 - GET / 200
10.0.0.8 - GET /login 200
10.0.0.5 - POST /login 401
10.0.0.9 - GET /dashboard 200
10.0.0.8 - GET /missing 404
10.0.0.5 - POST /payment 500
EOF

cat > "$DATA/error.log" <<'EOF'
ERROR disk usage threshold exceeded
ERROR upstream service unavailable
CRITICAL database pool exhausted
EOF

cat > "$DATA/users.txt" <<'EOF'
shankar:admin
aditya:developer
priya:tester
rahul:developer
Meera:operator
EOF

cat > "$DATA/services.conf" <<'EOF'
APP_NAME=DemoPortal
APP_PORT=8080
LOG_LEVEL=INFO
DB_HOST=localhost
CACHE_ENABLED=true
EOF

cat > "$DATA/status.txt" <<'EOF'
READY
STARTING
READY
STOPPED
EOF

cat > "$DATA/nested/worker.log" <<'EOF'
2026-10-14 09:04:00 INFO Worker started
2026-10-14 09:04:10 ERROR Job 42 failed
2026-10-14 09:04:20 INFO Worker waiting
EOF

cat > "$DATA/nested/archive/old.log" <<'EOF'
2025-01-10 10:00:00 INFO Archived job completed
2025-01-10 10:01:00 WARN Legacy retry
EOF

cat > "$DATA/config/nginx.conf" <<'EOF'
server {
    listen 80;
    server_name example.local;
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
}
EOF

: > "$DATA/empty.txt"
printf 'temporary practice file\n' > "$DATA/tmp/session.tmp"
printf 'Sample lab created at %s\n' "$DATA"
printf 'Move into it with: cd "%s"\n' "$DATA"
