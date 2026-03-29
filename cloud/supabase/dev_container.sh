#!/bin/bash
set -euo pipefail

STUDIO_PORT=3000
API_PORT=8000
DB_PORT=5432

usage() {
    echo "Usage: $0 {run|start|stop|delete|shell|prune}"
    echo ""
    echo "  run     Start stack and open Studio in browser"
    echo "  start   Start stack in background"
    echo "  stop    Stop all services"
    echo "  delete  Stop and remove all containers and volumes"
    echo "  shell   Open psql shell into the database"
    echo "  prune   Remove unused Docker objects"
    exit 1
}

check_env() {
    if [ ! -f .env ]; then
        echo "Missing .env file"
        exit 1
    fi
}

start_stack() {
    check_env
    echo "Starting Supabase stack..."
    docker compose up -d
    echo ""
    echo "Studio:   http://localhost:${STUDIO_PORT}"
    echo "API:      http://localhost:${API_PORT}"
    echo "Postgres: localhost:${DB_PORT}"
}

main() {
    local cmd="${1:-}"

    if [[ -z "$cmd" ]]; then
        usage
    fi

    case "$cmd" in
        run)
            start_stack
            xdg-open "http://localhost:${STUDIO_PORT}" 2>/dev/null || \
                echo "Open in browser: http://localhost:${STUDIO_PORT}"
            ;;
        start)
            start_stack
            ;;
        stop)
            docker compose stop
            echo "Stack stopped"
            ;;
        delete)
            docker compose down --volumes --remove-orphans
            echo "Stack deleted (volumes removed)"
            ;;
        shell)
            echo "Connecting to Postgres..."
            docker compose exec db psql -U postgres
            ;;
        prune)
            echo "Pruning unused Docker objects..."
            docker system prune --volumes --force
            echo "Prune complete"
            ;;
        *)
            usage
            ;;
    esac
}

main "$@"
