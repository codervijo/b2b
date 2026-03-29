#!/bin/bash
set -euo pipefail

usage() {
    echo "Usage: $0 {run|start|stop|delete|shell|prune}"
    exit 1
}

start_stack() {
    echo "Starting Formbricks..."
    docker compose up -d
    echo ""
    echo "App:     http://localhost:3000"
    echo "Mailhog: http://localhost:8025"
    echo "MinIO:   http://localhost:9001"
}

main() {
    local cmd="${1:-}"
    [[ -z "$cmd" ]] && usage

    case "$cmd" in
        run)
            start_stack
            xdg-open "http://localhost:3000" 2>/dev/null || echo "Open: http://localhost:3000"
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
            docker compose exec formbricks /bin/sh
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
