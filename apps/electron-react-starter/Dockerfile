# Use an official Node runtime as a parent image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Install dependencies
COPY package*.json ./
RUN npm install

# Install dependencies for Electron
RUN npm install -g concurrently

# Copy the rest of the application code
COPY . .

# Install dependencies for Electron and X11
RUN apt-get update && apt-get install -y \
    libgtk-3-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    dbus-x11 \
    libgbm1 \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libglu1-mesa

# Expose the DISPLAY environment variable
ENV DISPLAY=:0

# Ensure node_modules/.bin is in PATH
ENV PATH=/usr/src/app/node_modules/.bin:$PATH

# Expose port for React app
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
