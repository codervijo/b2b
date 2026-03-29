FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 xfce4-terminal x11vnc novnc websockify xvfb dbus-x11 \
    wget curl git build-essential python3 python3-pip \
    net-tools iproute2 ssl-cert \
    libsecret-1-dev libkrb5-dev libx11-dev libxkbfile-dev pkg-config \
    libnss3 libgbm1 libasound2 libxss1 libxtst6 \
    libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
    libxrandr2 libxcomposite1 libxdamage1 libxfixes3 libxext6 \
    libx11-xcb1 libxcb-dri3-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 via NodeSource (Ubuntu's default is too old)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/pearai-app

# Clone main repo
RUN git clone --depth=1 https://github.com/trypear/pearai-app.git .

# Clone submodules directly (--recurse-submodules fails with shallow clones)
RUN git clone --depth=1 https://github.com/trypear/pearai-submodule.git extensions/pearai-submodule
RUN git clone --depth=1 https://github.com/trypear/PearAI-Roo-Code extensions/PearAI-Roo-Code

# Build pearai-submodule extension
RUN cd extensions/pearai-submodule && ./scripts/install-and-build.sh

# Build PearAI-Roo-Code extension
RUN cd extensions/PearAI-Roo-Code && npm run install:all && npm run build

# Create symlink for pearai-ref (required by VSCode extension loader)
RUN ln -sf /opt/pearai-app/extensions/pearai-submodule/extensions/vscode \
    /opt/pearai-app/extensions/pearai-ref

# Install root dependencies and compile TypeScript
RUN npm install
RUN NODE_OPTIONS=--max-old-space-size=8192 npm run compile

# Create startup script — use printf to preserve newlines (echo does not interpret \n in single quotes)
RUN printf '%s\n' \
    '#!/bin/bash' \
    '' \
    'export DISPLAY=:99' \
    '' \
    '# Clean up stale lock files from previous runs' \
    'rm -f /tmp/.X99-lock /tmp/.X11-unix/X99' \
    '' \
    '# Start virtual display on :99 to avoid conflict with host display :0' \
    'Xvfb :99 -screen 0 1920x1080x24 &' \
    'sleep 2' \
    '' \
    '# Start dbus session (required by xfce4)' \
    'eval $(dbus-launch --sh-syntax)' \
    'export DBUS_SESSION_BUS_ADDRESS' \
    '' \
    '# Start XFCE desktop' \
    'startxfce4 &' \
    'sleep 2' \
    '' \
    '# Start VNC server (no password)' \
    'x11vnc -forever -shared -rfbport 5900 -display :99 -nopw &' \
    '' \
    '# Start noVNC websockify' \
    'websockify --web=/usr/share/novnc/ 6080 localhost:5900 &' \
    'sleep 1' \
    '' \
    '# Launch PearAI' \
    'cd /opt/pearai-app' \
    'exec ./scripts/code.sh --no-sandbox --disable-gpu' \
    > /usr/local/bin/start-pearai.sh && \
    chmod +x /usr/local/bin/start-pearai.sh

EXPOSE 5900 6080

WORKDIR /opt/pearai-app

CMD ["/usr/local/bin/start-pearai.sh"]
