#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

exec flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 "$@"
