#!/bin/bash
set -euo pipefail

# Configuration
CONTAINER="pai1"
VNC_PORT=5900
NOVNC_PORT=6080
PRE_BUILD_SCRIPT="./pre_build.sh"
POST_BUILD_SCRIPT="./post_build.sh"

usage() {
    echo "Usage: $0 {run|start|shell|stop|delete|prune}"
    exit 1
}

run_script_if_exists() {
    local script="$1"
    local label="$2"
    if [[ -f "$script" && -x "$script" ]]; then
        echo "Running $label script: $script"
        "$script" || { echo "$label script failed: $script"; exit 1; }
    elif [[ -f "$script" ]]; then
        echo "$label script exists but is not executable: $script"
    fi
}

gpu_flag() {
    if command -v nvidia-smi >/dev/null && nvidia-smi >/dev/null 2>&1; then
        echo "--gpus=all"
    else
        echo ""
    fi
}

container_exists() {
    docker ps -aq -f name="^${CONTAINER}$" | grep -q .
}

container_running() {
    docker ps -q -f name="^${CONTAINER}$" | grep -q .
}

build_image() {
    run_script_if_exists "$PRE_BUILD_SCRIPT" "pre-build"
    echo "Building Docker image: $CONTAINER"
    docker build \
        --network=host \
        --tag "${CONTAINER}:latest" \
        --cache-from "${CONTAINER}:latest" \
        . 2>/dev/null || \
    docker build --network=host --tag "${CONTAINER}:latest" .
    run_script_if_exists "$POST_BUILD_SCRIPT" "post-build"
}

start_container() {
    if container_running; then
        echo "Container '${CONTAINER}' is already running"
        return
    fi

    GPU_ARG=$(gpu_flag)

    echo "Starting container '${CONTAINER}'"
    docker run -d \
        --name "$CONTAINER" \
        ${GPU_ARG} \
        --network=host \
        -p "${VNC_PORT}:${VNC_PORT}" \
        -p "${NOVNC_PORT}:${NOVNC_PORT}" \
        --cap-add SYS_ADMIN \
        --security-opt seccomp=unconfined \
        "$CONTAINER"

    echo "PearAI is starting..."
    echo "Open in browser: http://localhost:${NOVNC_PORT}/vnc.html"
}

main() {
    local cmd="${1:-}"

    if [[ -z "$cmd" ]]; then
        build_image
        start_container
        exit 0
    fi

    case "$cmd" in
        run)
            build_image
            start_container
            xdg-open "http://localhost:${NOVNC_PORT}/vnc.html" 2>/dev/null || \
                echo "Open in browser: http://localhost:${NOVNC_PORT}/vnc.html"
            ;;
        start)
            build_image
            start_container
            ;;
        shell)
            if container_running; then
                docker exec -it "$CONTAINER" /bin/bash
            else
                echo "Container '${CONTAINER}' is not running"
                exit 1
            fi
            ;;
        stop)
            if container_running; then
                docker stop "$CONTAINER"
                echo "Container stopped"
            else
                echo "Container not running"
                exit 1
            fi
            ;;
        delete)
            if container_exists; then
                container_running && docker stop "$CONTAINER"
                docker rm "$CONTAINER"
                docker rmi "$CONTAINER"
                echo "Container deleted"
            else
                echo "Container does not exist"
                exit 1
            fi
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
