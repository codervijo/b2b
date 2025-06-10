#!/bin/bash
set -euo pipefail

echo "✅ Post-build: image is ready"
sudo docker images | grep cai3 || true
