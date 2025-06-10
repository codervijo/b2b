#!/bin/bash
set -euo pipefail

echo "🔧 Verifying NVIDIA GPU..."

if command -v nvidia-smi >/dev/null && nvidia-smi >/dev/null 2>&1; then
    echo "✅ NVIDIA GPU detected"

    # 1. Set up the repository
    distribution=$(. /etc/os-release; echo "${ID}${VERSION_ID}")  # e.g., ubuntu24.04
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
        sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit.gpg

    curl -fsSL https://nvidia.github.io/libnvidia-container/${distribution}/libnvidia-container.list | \
        sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit.gpg] https://#g' | \
        sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

    # 2. Install the toolkit
    sudo apt-get update
    sudo apt-get install -y nvidia-container-toolkit

    # 3. Configure Docker runtime
    sudo nvidia-ctk runtime configure --runtime=docker

    # 4. Restart Docker
    echo "♻️ Restarting Docker service..."
    sudo systemctl restart docker

    echo "✅ NVIDIA Container Toolkit setup complete."
else
    echo "⚠️ No NVIDIA GPU detected or NVIDIA drivers are not installed properly."
fi
