#!/usr/bin/env bash
# Build the millie runtime image. The build context must be the millie repo
# (the Dockerfile COPYs its pyproject.toml), so the context is passed in.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MILLIE_ROOT="${1:-$HOME/work/projects/droyfun/millie}"
IMAGE="${MILLIE_IMAGE:-millie-dev}"
read -ra DOCKER <<< "${DOCKER_CMD:-docker}"

if [ ! -f "$MILLIE_ROOT/pyproject.toml" ]; then
    echo "✗ no pyproject.toml at $MILLIE_ROOT — pass the millie repo path as \$1" >&2
    exit 2
fi

echo "↷ building $IMAGE  (definition: $HERE/Dockerfile, context: $MILLIE_ROOT)"
"${DOCKER[@]}" build -f "$HERE/Dockerfile" -t "$IMAGE" "$MILLIE_ROOT"
echo "✓ built $IMAGE"
