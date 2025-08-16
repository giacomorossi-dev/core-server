#!/usr/bin/env bash
set -Eeuo pipefail

STACKS=("portainer" "caddy" "cloudflared")
CMD="${1:-}"

case "$CMD" in
  up|stop|restart) ;;
  *) echo "Uso: $0 {up|stop|restart}"; exit 1 ;;
esac

# === trova la dir del file cli.sh, seguendo eventuali symlink ===
SCRIPT_SRC="${BASH_SOURCE[0]}"
while [ -h "$SCRIPT_SRC" ]; do
  DIR="$(cd -P "$(dirname "$SCRIPT_SRC")" && pwd)"
  SCRIPT_SRC="$(readlink "$SCRIPT_SRC")"
  [[ "$SCRIPT_SRC" != /* ]] && SCRIPT_SRC="$DIR/$SCRIPT_SRC"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SCRIPT_SRC")" && pwd)"

# === root del repo: se cli.sh è in scripts/, risali di uno ===
if [ -d "$SCRIPT_DIR/portainer" ] || [ -d "$SCRIPT_DIR/caddy" ] || [ -d "$SCRIPT_DIR/cloudflared" ]; then
  ROOT="$SCRIPT_DIR"
else
  ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
fi

for S in "${STACKS[@]}"; do
  [ -d "$ROOT/$S" ] || continue
  echo "==> $S : $CMD"
  (
    cd "$ROOT/$S"
    case "$CMD" in
      up)      docker compose up -d ;;
      stop)    docker compose stop ;;
      restart) docker compose restart ;;
    esac
  )
done
