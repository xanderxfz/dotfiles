#!/usr/bin/env bash
#
# Download and install llama for ubuntu amd64/arm64
#
#
# Exit immediately if a command exits with a non-zero status
set -e

TARGET="/opt/llama.cpp/bin"
SERVICE_NAME="llama-server.service"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Detect cpu architecture
ARCH_RAW=$(uname -m)
if [[ "$ARCH_RAW" == "x86_64" ]]; then
    ARCH_PATTERN="ubuntu-vulkan-x64"
elif [[ "$ARCH_RAW" == "aarch64" ]]; then
    ARCH_PATTERN="ubuntu-vulkan-arm64"
else
    echo "Error: Unsupported architecture $ARCH_RAW"
    exit 1
fi


# Get the latest download URL
URL=$(wget -qO- "https://api.github.com/repos/ggml-org/llama.cpp/releases/latest" | \
  jq -r --arg PATTERN "$ARCH_PATTERN" '.assets[] | select(.name | contains($PATTERN)) | .browser_download_url')

if [[ -z "$URL" || "$URL" == "null" ]]; then
    echo "Error: Could not find a release for $ARCH_PATTERN"
    exit 1
fi


# Download and unpack
log_info "Downloading ${GREEN}$URL${NC}"
TMP=$(mktemp -d)
wget -qO- "$URL" | tar -xz -C "$TMP"


# Stop the service if it is running
#if systemctl list-unit-files | grep -q "^${SERVICE_NAME}"; then
if systemctl is-active --quiet "$SERVICE_NAME"; then
    log_info "Stopping $SERVICE_NAME for update..."
    sudo systemctl stop "$SERVICE_NAME"
    WAS_RUNNING=true
fi


# Clean and replace
log_info "Updating binaries in ${GREEN}$TARGET${NC}"
sudo mkdir -p "$TARGET"
sudo rm -rf "${TARGET:?}"/*
sudo mv "$TMP"/*/* "$TARGET" 2>/dev/null || sudo mv "$TMP"/* "$TARGET"
rm -rf "$TMP"


# Restart the service if needed
if [ "$WAS_RUNNING" = true ]; then
    log_info "Restarting $SERVICE_NAME..."
    sudo systemctl start "$SERVICE_NAME"
else
    log_info "Update complete. Service was not running, so it remains stopped."
fi

log_info "All done. Update completed."
