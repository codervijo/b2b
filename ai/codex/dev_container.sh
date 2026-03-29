#!/bin/bash
set -euo pipefail

CONTAINER="codex1"
WORKSPACE_DIR="${PWD}/workspace"

usage() {
    echo "Usage: $0 {start|shell|stop|delete|prune}"
    exit 1
}

container_exists() {
    sudo docker ps -aq -f name="^${CONTAINER}$" | grep -q .
}

container_running() {
    sudo docker ps -q -f name="^${CONTAINER}$" | grep -q .
}

build_image() {
    echo "Building Docker image: $CONTAINER"
    sudo docker build \
        --network=host \
        --tag "${CONTAINER}:latest" \
        --cache-from "${CONTAINER}:latest" \
        . 2>/dev/null || \
    sudo docker build --network=host --tag "${CONTAINER}:latest" .
}

start_container() {
    if container_running; then
        echo "Container '${CONTAINER}' is already running"
        return
    fi

    mkdir -p "$WORKSPACE_DIR"

    echo "Starting container '${CONTAINER}'"
    sudo docker run -d \
        --name "$CONTAINER" \
        -e OPENAI_API_KEY="${OPENAI_API_KEY:-}" \
        -v "$WORKSPACE_DIR:/workspace" \
        -v "$HOME/.codex:/root/.codex" \
        --network=host \
        "$CONTAINER" tail -f /dev/null
}

main() {
    local cmd="${1:-}"

    if [[ -z "$cmd" ]]; then
        build_image
        start_container
        sudo docker exec -it "$CONTAINER" /bin/bash
        exit 0
    fi

    case "$cmd" in
        start)
            build_image
            start_container
            ;;
        shell)
            if container_running; then
                sudo docker exec -it "$CONTAINER" /bin/bash
            else
                echo "Container '${CONTAINER}' is not running"
                exit 1
            fi
            ;;
        stop)
            if container_running; then
                sudo docker stop "$CONTAINER"
                echo "Container stopped"
            else
                echo "Container not running"
                exit 1
            fi
            ;;
        delete)
            if container_exists; then
                container_running && sudo docker stop "$CONTAINER"
                sudo docker rm "$CONTAINER"
                sudo docker rmi "$CONTAINER"
                echo "Container deleted"
            else
                echo "Container does not exist"
                exit 1
            fi
            ;;
        prune)
            echo "Pruning unused Docker objects..."
            sudo docker system prune --volumes --force
            echo "Prune complete"
            ;;
        *)
            usage
            ;;
    esac
}

main "$@"
