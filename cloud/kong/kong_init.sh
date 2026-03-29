#!/bin/bash

# Function to clone a repository if not already cloned
clone_if_not_exists() {
    repo_url=$1
    repo_dir=$2

    if [ ! -d "$repo_dir" ]; then
        echo "Cloning $repo_url into $repo_dir..."
        git clone "$repo_url" "$repo_dir"
    else
        echo "Repository $repo_dir already exists."
    fi
}

# Clone the main Kong repository
clone_if_not_exists "https://github.com/Kong/kong.git" "kong"
clone_if_not_exists "https://github.com/Kong/docker-kong" "docker-kong"

# Clone other required repositories for building Kong
clone_if_not_exists "https://github.com/Kong/lua-kong-nginx-module.git" "lua-kong-nginx-module"

# Navigate to the kong directory
cd kong

# (Optional) You can add build steps here to prepare the source for building

echo "Kong and required repositories are cloned. You can now build Kong from source."
