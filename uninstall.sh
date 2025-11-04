#!/data/data/com.termux/files/usr/bin/bash
# TPT Uninstallation Script

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}[+] Termux Pentesting Toolkit (TPT) Uninstallation${NC}"
echo -e "${YELLOW}[+] ===============================================${NC}"

# Check if running on Termux
if [ ! -d "/data/data/com.termux/files/usr" ]; then
    echo -e "${RED}[!] Error: This script must be run in Termux${NC}"
    exit 1
fi

# Confirmation
echo -e "${YELLOW}[!] This will remove all TPT files and configurations${NC}"
read -p "Are you sure you want to uninstall? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo -e "${GREEN}[+] Uninstallation cancelled${NC}"
    exit 0
fi

# Remove installation directory
INSTALL_DIR="$HOME/tpt"
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}[+] Removing installation directory: $INSTALL_DIR${NC}"
    rm -rf "$INSTALL_DIR"
fi

# Remove symlink
if [ -L "$PREFIX/bin/tpt" ]; then
    echo -e "${YELLOW}[+] Removing symlink: $PREFIX/bin/tpt${NC}"
    rm "$PREFIX/bin/tpt"
fi

# Remove configuration file
CONFIG_FILE="$HOME/.tpt_config"
if [ -f "$CONFIG_FILE" ]; then
    echo -e "${YELLOW}[+] Removing configuration file: $CONFIG_FILE${NC}"
    rm "$CONFIG_FILE"
fi

# Remove tools directory (optional)
read -p "Do you want to remove installed tools directory ($HOME/tpt-tools)? (y/N): " remove_tools
if [[ "$remove_tools" == "y" || "$remove_tools" == "Y" ]]; then
    if [ -d "$HOME/tpt-tools" ]; then
        echo -e "${YELLOW}[+] Removing tools directory: $HOME/tpt-tools${NC}"
        rm -rf "$HOME/tpt-tools"
    fi
fi

echo -e "${GREEN}[+] Uninstallation completed successfully!${NC}"
