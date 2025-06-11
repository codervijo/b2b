#!/bin/bash
set -euo pipefail

# Config
CONTAINER="cai5"
HOST_PORT=6400
CONTAINER_PORT=3445
APP_DIR="${PWD}"
VOLUME_MOUNT="${APP_DIR}:/usr/src/app/"
MODELS_DIR="${APP_DIR}/models"
CONFIG_DIR="${APP_DIR}/config"
PRE_BUILD_SCRIPT="./pre_build.sh"
POST_BUILD_SCRIPT="./post_build.sh"

PRE_BUILD_SCRIPT="${PRE_BUILD_SCRIPT:-}"
POST_BUILD_SCRIPT="${POST_BUILD_SCRIPT:-}"

# Helper
usage() {
    echo "Usage: $0 {start|shell|stop|delete|prune}"
    exit 1
}

run_script_if_exists() {
    local script="$1"
    local label="$2"

    if [[ -n "$script" ]]; then
        if [[ -f "$script" && -x "$script" ]]; then
            echo "🟡 Running $label script: $script"
            "$script" || {
                echo "❌ $label script failed: $script"
                exit 1
            }
        else
            echo "⚠️  $label script is missing or not executable: $script"
        fi
    fi
}

gpu_flag() {
    if command -v nvidia-smi >/dev/null && nvidia-smi >/dev/null 2>&1; then
        echo "--gpus=all"
    else
        echo ""
    fi
}

build_image() {
    run_script_if_exists "$PRE_BUILD_SCRIPT" "pre-build"
    echo "🔧 Building Docker image: $CONTAINER"
    sudo docker build --network=host \
        --tag "${CONTAINER}:latest" \
        --cache-from "${CONTAINER}:latest" \
        -t "$CONTAINER" .
    run_script_if_exists "$POST_BUILD_SCRIPT" "post-build"
}

container_exists() {
    sudo docker ps -aq -f name="^${CONTAINER}$" | grep -q .
}

container_running() {
    sudo docker ps -q -f name="^${CONTAINER}$" | grep -q .
}

compose_exists() {
    [[ -f docker-compose.yml || -f compose.yaml ]]
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
        --network=host \
        -v "$VOLUME_MOUNT" \
        -v "${MODELS_DIR}:/home/comfy/models" \
        -v "${CONFIG_DIR}:/home/comfy/config" \
        -p "${HOST_PORT}:${CONTAINER_PORT}" \
        "$CONTAINER" tail -f /dev/null
}

start_with_compose() {
    echo "🧱 Compose file detected. Starting with docker-compose..."
    sudo docker compose up --build -d
}

main() {
    mkdir -p "$MODELS_DIR" "$CONFIG_DIR"

    local cmd="${1:-start}"
    case "$cmd" in
        start)
            if compose_exists; then
                start_with_compose
            else
                build_image
                start_container
            fi
            ;;
        shell)
            container_running && sudo docker exec -it "$CONTAINER" /bin/bash || {
                echo "❌ Container '${CONTAINER}' is not running"
                exit 1
            }
            ;;
        stop)
            compose_exists && sudo docker compose down || {
                container_running && sudo docker stop "$CONTAINER" && echo "🛑 Container stopped" || {
                    echo "❌ Container not running"
                    exit 1
                }
            }
            ;;
        delete)
            compose_exists && sudo docker compose down --volumes --remove-orphans || {
                if container_exists; then
                    container_running && sudo docker stop "$CONTAINER"
                    sudo docker rm "$CONTAINER"
                    sudo docker rmi "$CONTAINER"
                    echo "🧹 Container deleted"
                else
                    echo "❌ Container does not exist"
                    exit 1
                fi
            }
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
