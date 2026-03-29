#!/bin/bash
set -euo pipefail

usage() {
    echo "Usage: $0 {run|start|stop|delete|shell|prune}"
    exit 1
}

start_stack() {
    echo "Starting Kong..."
    docker compose up -d
    echo ""
    echo "Access: http://localhost:8001"
}

main() {
    local cmd="${1:-}"
    [[ -z "$cmd" ]] && usage

    case "$cmd" in
        run)
            start_stack
            xdg-open "http://localhost:8001" 2>/dev/null || echo "Open: http://localhost:8001"
            ;;
        start)
            start_stack
            ;;
        stop)
            docker compose stop
            echo "Stopped"
            ;;
        delete)
            docker compose down --volumes --remove-orphans
            echo "Deleted (volumes removed)"
            ;;
        shell)
            docker compose ps --services | head -1 | xargs -I{} docker compose exec {} /bin/sh
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
