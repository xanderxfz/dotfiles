#!/usr/bin/env bash
#

# Exit immediately if a command exits with a non-zero status
set -e

L_USER="llamauser"
L_GROUP="llamauser"
TARGET_DIR="/opt/llama.cpp"
BIN_DIR="$HOME/bin"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_info "--- Starting llama.cpp System Installation ---"

# Create Group if it doesn't exist
if ! getent group "$L_GROUP" >/dev/null; then
    log_info "Creating group ${GREEN}$L_GROUP${NC}..."
    sudo groupadd "$L_GROUP"
else
    log_info "Group ${GREEN}$L_GROUP${NC} already exists."
fi

# Create User if it doesn't exist and add to video/render groups for GPU access
if ! id -u "$L_USER" >/dev/null 2>&1; then
    log_info "Creating system user ${GREEN}$L_USER${NC}..."
    sudo useradd -r -g "$L_GROUP" -s /bin/false "$L_USER"
    sudo usermod -aG render,video "$L_USER" 2>/dev/null || echo "Warning: Could not add to GPU groups."
else
    log_info "User ${GREEN}$L_USER${NC} already exists."
fi


# Setup Directory Structure
log_info "Preparing directories..."
sudo mkdir -p "$TARGET_DIR/bin" "$TARGET_DIR/models"
mkdir -p "$BIN_DIR"


# Copy Scripts and Service Files
log_info "Copying files..."
sudo cp llama.ini "$TARGET_DIR/"
log_info "Successfully copied ${GREEN}llama.ini${NC} to ${GREEN}$TARGET_DIR${NC}"

cp update_llama.sh "$BIN_DIR/"
chmod +x "$BIN_DIR/update_llama.sh"
log_info "Successfully copied ${GREEN}update_llama.sh${NC} to ${GREEN}$BIN_DIR${NC}"

sudo cp etc/systemd/system/llama-server.service /etc/systemd/system/
log_info "Successfully copied ${GREEN}llama-server.service${NC} to ${GREEN}/etc/systemd/system/${NC}"


# Fix Permissions
log_info "Setting ownership of ${GREEN}$TARGET_DIR${NC} to ${GREEN}$L_USER${NC}"
sudo chown -R "$L_USER":"$L_GROUP" "$TARGET_DIR"

# Initialize Systemd
log_info "Reloading systemd daemon..."
sudo systemctl daemon-reload


log_info "-----------------------------------------------"
log_info "Installation Complete!"
log_info "Next steps:"
log_info "1. Run: ${GREEN}~/bin/update_llama.sh${NC} (to download the latest binaries)"
log_info "2. Place your GGUF model in ${GREEN}$TARGET_DIR/models/${NC} if needed"
log_info "3. Run: ${GREEN}sudo systemctl enable --now llama-server${NC}"
log_info "-----------------------------------------------"
