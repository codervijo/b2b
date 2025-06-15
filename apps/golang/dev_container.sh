#!/bin/bash

CONTAINER=go2
HOST_PORT=3400
CONTAINER_PORT=3445
CONTAINER_BASE=${CONTAINER}
CONTAINER_NAME="Go lang"
VOLUME_MOUNT="${PWD}:/usr/src/app/"

# Usage
usage() {
    echo "Usage: $0 {start|shell|stop|delete}"
    exit 1
}

# Build image
build_image() {
    echo "Building image..."
    sudo docker build --network=host --tag ${CONTAINER}:latest --cache-from ${CONTAINER}:latest -t ${CONTAINER} . || \
    sudo docker build --network=host -t ${CONTAINER} .
}

# Check if container exists
container_exists() {
    sudo docker ps -aq -f name="^${CONTAINER}$" | grep -q .
}

# Check if container is running
container_running() {
    sudo docker ps -q -f name="^${CONTAINER}$" | grep -q .
}

# Check if docker-compose file exists
compose_exists() {
    [[ -f docker-compose.yml || -f compose.yaml ]]
}

# Start container (manual docker run fallback)
start_container() {
    if container_running; then
        echo "Container ${CONTAINER} is already running"
    else
        echo "Starting container..."
        sudo docker run -d -v "${VOLUME_MOUNT}" --network=host -p ${HOST_PORT}:${CONTAINER_PORT} \
            --name ${CONTAINER} ${CONTAINER} tail -f /dev/null
        echo "Container ${CONTAINER} started"
    fi
}

# Start container via compose if available
start_with_compose() {
    echo "Compose file detected. Using docker compose..."
    sudo docker compose up --build -d
}

# Main logic
if [ $# -eq 0 ]; then
    if compose_exists; then
        start_with_compose
    else
        build_image
        start_container
    fi
    sudo docker exec -it ${CONTAINER} /bin/bash || true
    exit 0
fi

case "$1" in
    start)
        if compose_exists; then
            start_with_compose
        else
            build_image
            start_container
        fi
        ;;
    shell)
        CONTAINER=$(docker ps --filter "ancestor=${CONTAINER_BASE}" --format "{{.ID}}" | head -n 1)

        if [ -n "$CONTAINER" ]; then
            sudo docker exec -it "$CONTAINER" /bin/sh
        else
            echo "No running ${CONTAINER_NAME} container found."
            exit 1
        fi
        ;;
    stop)
        if compose_exists; then
            sudo docker compose down
        elif container_running; then
            sudo docker stop ${CONTAINER}
            echo "Container ${CONTAINER} stopped"
        else
            echo "Container ${CONTAINER} is not running"
            exit 1
        fi
        ;;
    delete)
        if compose_exists; then
            sudo docker compose down --volumes --remove-orphans
        elif container_exists; then
            if container_running; then
                sudo docker stop ${CONTAINER}
            fi
            sudo docker rm ${CONTAINER}
            sudo docker rmi ${CONTAINER}
            echo "Container ${CONTAINER} deleted"
        else
            echo "Container ${CONTAINER} does not exist"
            exit 1
        fi
        ;;
    *)
        usage
        ;;
esac
