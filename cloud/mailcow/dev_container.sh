#!/bin/bash
set -euo pipefail

MAILCOW_DIR="${PWD}/mailcow-dockerized"
MAILCOW_REPO="https://github.com/mailcow/mailcow-dockerized.git"

usage() {
    echo "Usage: $0 {run|start|stop|delete|shell|prune}"
    echo ""
    echo "  run    Clone (if needed), configure, and start mailcow"
    echo "  start  Start existing mailcow stack"
    echo "  stop   Stop mailcow stack"
    echo "  delete Stop and remove all containers and volumes"
    echo "  shell  Open shell in mailcow-postfix container"
    exit 1
}

ensure_cloned() {
    if [ ! -d "$MAILCOW_DIR" ]; then
        echo "Cloning mailcow-dockerized..."
        git clone "$MAILCOW_REPO" "$MAILCOW_DIR"
    fi
    cp -f mailcow.conf "$MAILCOW_DIR/mailcow.conf"
}

start_stack() {
    ensure_cloned
    cd "$MAILCOW_DIR"
    echo "Starting mailcow..."
    docker compose up -d
    echo ""
    echo "Mailcow UI: https://localhost"
    echo "Default credentials: admin / moohoo"
}

main() {
    local cmd="${1:-}"
    [[ -z "$cmd" ]] && usage

    case "$cmd" in
        run)
            start_stack
            xdg-open "https://localhost" 2>/dev/null || echo "Open: https://localhost"
            ;;
        start)
            start_stack
            ;;
        stop)
            cd "$MAILCOW_DIR"
            docker compose stop
            echo "Stopped"
            ;;
        delete)
            cd "$MAILCOW_DIR"
            docker compose down --volumes --remove-orphans
            echo "Deleted (volumes removed)"
            ;;
        shell)
            cd "$MAILCOW_DIR"
            docker compose exec postfix-mailcow /bin/bash
            ;;
        prune)
            docker system prune --volumes --force
            ;;
        *)
            usage
            ;;
    esac
}

main "$@"
