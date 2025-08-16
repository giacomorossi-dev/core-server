#!/usr/bin/env bash
set -e

STACKS=("portainer" "caddy" "cloudflared")

CMD="${1:-}"

if [[ "$CMD" != "up" && "$CMD" != "stop" && "$CMD" != "restart" ]]; then
  echo "Uso: $0 {up|stop|restart}"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

for S in "${STACKS[@]}"; do
  echo "==> $S : $CMD"
  ( cd "$BASE_DIR/$S"
    case "$CMD" in
      up)      docker compose up -d ;;
      stop)    docker compose stop ;;
      restart) docker compose restart ;;
    esac
  )
done
