#!/bin/bash
set -euo pipefail

# Configuration
CONTAINER="odevai3"
HOST_PORT=3000
CONTAINER_PORT=3000
APP_DIR="${PWD}"
VOLUME_MOUNT="${APP_DIR}:/app"
WORKSPACE_DIR="${APP_DIR}/workspace"
DOCKER_SOCKET="/var/run/docker.sock"
PRE_BUILD_SCRIPT="./pre_build.sh"
POST_BUILD_SCRIPT="./post_build.sh"

# Helper functions
usage() {
    echo "Usage: $0 {start|shell|stop|delete|prune}"
    exit 1
}

run_script_if_exists() {
    local script="$1"
    local label="$2"
    if [[ -f "$script" && -x "$script" ]]; then
        echo "🟡 Running $label script: $script"
        "$script" || {
            echo "❌ $label script failed: $script"
            exit 1
        }
    elif [[ -f "$script" ]]; then
        echo "⚠️  $label script exists but is not executable: $script"
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
    sudo docker ps -aq -f name="^${CONTAINER}$" | grep -q .
}

container_running() {
    sudo docker ps -q -f name="^${CONTAINER}$" | grep -q .
}

build_image() {
    run_script_if_exists "$PRE_BUILD_SCRIPT" "pre-build"
    echo "🔧 Building Docker image: $CONTAINER"
    sudo docker build \
        --network=host \
        --tag "${CONTAINER}:latest" \
        --cache-from "${CONTAINER}:latest" \
        .
    run_script_if_exists "$POST_BUILD_SCRIPT" "post-build"
}

start_container() {
    if container_running; then
        echo "✅ Container '${CONTAINER}' is already running"
        return
    fi

    GPU_ARG=$(gpu_flag)

    echo "🚀 Starting container '${CONTAINER}'"
    sudo docker run -d \
        --name "$CONTAINER" \
        ${GPU_ARG} \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v "$VOLUME_MOUNT" \
        -v "$WORKSPACE_DIR:/opt/workspace_base" \
        -v "$DOCKER_SOCKET:$DOCKER_SOCKET" \
        -v "$HOME/.opendevin:/root/.opendevin" \
        --network=host \
        -p "${HOST_PORT}:${CONTAINER_PORT}" \
        "$CONTAINER" tail -f /dev/null
}

main() {
    local cmd="${1:-start}"
    case "$cmd" in
        start)
            build_image
            start_container
            ;;
        shell)
            if container_running; then
                sudo docker exec -it "$CONTAINER" /bin/bash
            else
                echo "❌ Container '${CONTAINER}' is not running"
                exit 1
            fi
            ;;
        stop)
            if container_running; then
                sudo docker stop "$CONTAINER"
                echo "🛑 Container stopped"
            else
                echo "❌ Container not running"
                exit 1
            fi
            ;;
        delete)
            if container_exists; then
                container_running && sudo docker stop "$CONTAINER"
                sudo docker rm "$CONTAINER"
                sudo docker rmi "$CONTAINER"
                echo "🧹 Container deleted"
            else
                echo "❌ Container does not exist"
                exit 1
            fi
            ;;
        prune)
            echo "🧽 Pruning unused Docker objects..."
            sudo docker system prune --volumes --force
            echo "✅ Prune complete"
            ;;
        *)
            usage
            ;;
    esac
}

main "$@"
