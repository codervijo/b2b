# Specify the desired Node.js version
NODE_VERSION := 18.16.0  # Change this to your desired version

# Check if running inside Docker
IS_DOCKER := $(shell [ -f /.dockerenv ] && echo "yes" || echo "no")

# Ensure running inside Docker
ifeq ($(IS_DOCKER),no)
$(warning "Warning: Not running inside Docker. Make sure this is intentional.")
endif

# Print help
help:
	@echo "${APP_NAME} app Make options"
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  buildsh   - Shell to build"
	@echo "  build     - Build the project"
	@echo "  test      - Run tests"
	@echo "  clean     - Clean the build artifacts"
	@echo "  help      - Show this help message"

.PHONY: all install_nvm install_node clean

all: install_nvm install_node

.PHONY: buildsh
buildsh: mermaid-live-editor  mermaid
ifeq ($(IS_DOCKER),yes)
	$(error "Already in docker container")
endif
	(bash ./dev_container.sh)

# Install NVM
install_nvm:
ifeq ($(IS_DOCKER),no)
	$(error "NOT in docker container")
endif
	@echo "Installing NVM (Node Version Manager)..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
	@echo "NVM installed. Please restart your terminal or run the following command:"
	@echo "export NVM_DIR=\"$$(HOME)/.nvm\" && [ -s \"$$(nvm --version)\" ] && . \"$$(nvm --version)\"/nvm.sh"

# Install Node.js using NVM
install_node: install_nvm
ifeq ($(IS_DOCKER),no)
	$(error "NOT in docker container")
endif
	@echo "Installing Node.js version $(NODE_VERSION)..."
	@bash -c "source $$HOME/.nvm/nvm.sh && nvm install $(NODE_VERSION) && nvm use $(NODE_VERSION) && nvm alias default $(NODE_VERSION)"
	@echo "Node.js installed successfully."

preinstall: install_node install_nvm 
ifeq ($(IS_DOCKER),no)
	$(error "NOT in docker container")
endif

build:
ifeq ($(IS_DOCKER),no)
	$(error "NOT in docker container")
endif

/usr/local/bin/pnpm:
	npm install -g pnpm

NPM_CMD = pnpm start

mermaid-live-editor:
	git clone https://github.com/mermaid-js/mermaid-live-editor.git

mermaid:
	git clone git@github.com:mermaid-js/mermaid.git

live: mermaid-live-editor/
ifeq ($(IS_DOCKER),no)
	$(error "NOT in docker container")
endif
	(git config --global --add safe.directory $(PWD)/mermaid-live-editor)
	(cd mermaid-live-editor/ && pnpm install && pnpm dev)

cli:
ifeq ($(IS_DOCKER),no)
	$(error "NOT in docker container")
endif
	npm install -g @mermaid-js/mermaid-cli

.PHONY:clean
clean:
	@echo "Cleaning up..."
	sudo rm -rf mermaid mermaid-live-editor
	@echo "Cleanup completed."
