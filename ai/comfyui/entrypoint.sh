#!/bin/bash
set -euo pipefail

echo "🚀 Starting ComfyUI main script inside container..."

# Optional: wait for GPU to be ready
if command -v nvidia-smi >/dev/null && nvidia-smi >/dev/null 2>&1; then
    echo "✅ GPU is available inside container."
else
    echo "⚠️ GPU not detected inside container. Proceeding anyway..."
fi

# Run ComfyUI
cd /usr/src/app/ComfyUI
pip3 install --upgrade pip && \
pip3 install --user -r requirements.txt

python3 main.py
