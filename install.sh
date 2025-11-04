#!/data/data/com.termux/files/usr/bin/bash
# TPT Installation Script

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}[+] Termux Pentesting Toolkit (TPT) Installation${NC}"
echo -e "${YELLOW}[+] ============================================${NC}"

# Check if running on Termux
if [ ! -d "/data/data/com.termux/files/usr" ]; then
    echo -e "${RED}[!] Error: This script must be run in Termux${NC}"
    exit 1
fi

# Create installation directory
INSTALL_DIR="$HOME/tpt"
echo -e "${YELLOW}[+] Creating installation directory: $INSTALL_DIR${NC}"
mkdir -p "$INSTALL_DIR"

# Copy all files to installation directory
echo -e "${YELLOW}[+] Copying files to installation directory...${NC}"
cp -r ./* "$INSTALL_DIR/" 2>/dev/null || true

# Make scripts executable
echo -e "${YELLOW}[+] Setting executable permissions...${NC}"
chmod +x "$INSTALL_DIR/tpt.sh"
chmod +x "$INSTALL_DIR/install.sh"
chmod +x "$INSTALL_DIR/uninstall.sh"

# Create symlink in $PREFIX/bin
echo -e "${YELLOW}[+] Creating symlink in $PREFIX/bin...${NC}"
ln -sf "$INSTALL_DIR/tpt.sh" "$PREFIX/bin/tpt"

# Display installation success
echo -e "${GREEN}[+] Installation completed successfully!${NC}"
echo -e "${GREEN}[+] Run 'tpt' from anywhere to start the toolkit${NC}"
echo -e "${GREEN}[+] Configuration file will be created at ~/.tpt_config${NC}"
