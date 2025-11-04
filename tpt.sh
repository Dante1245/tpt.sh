#!/data/data/com.termux/files/usr/bin/bash
# Termux Pentesting Toolkit (TPT)
# Author: Pentester Toolkit
# Description: All-in-one pentesting script for Termux environment

# Colors for output formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
show_banner() {
    clear
    echo -e "${RED}"
    echo "████████╗██████╗ ███████╗████████╗██╗███╗   ██╗ ██████╗ "
    echo "╚══██╔══╝██╔══██╗██╔════╝╚══██╔══╝██║████╗  ██║██╔════╝ "
    echo "   ██║   ██████╔╝█████╗     ██║   ██║██╔██╗ ██║██║  ███╗"
    echo "   ██║   ██╔══██╗██╔══╝     ██║   ██║██║╚██╗██║██║   ██║"
    echo "   ██║   ██║  ██║███████╗   ██║   ██║██║ ╚████║╚██████╔╝"
    echo "   ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ "
    echo -e "${NC}"
    echo "        Termux Pentesting Toolkit (TPT)"
    echo "  Comprehensive All-In-One Pentesting Script"
    echo ""
}

# Check if running on Termux
check_termux() {
    if [ ! -d "/data/data/com.termux/files/usr" ]; then
        echo -e "${RED}[!] Error: This script must be run in Termux${NC}"
        exit 1
    fi
}

# Install required packages
install_packages() {
    echo -e "${YELLOW}[+] Installing required packages...${NC}"
    
    # Update package list
    pkg update -y
    
    # Install essential packages
    pkg install -y root-repo
    pkg install -y unstable-repo
    pkg install -y x11-repo
    
    # Install pentesting tools
    pkg install -y nmap
    pkg install -y hydra
    pkg install -y sqlmap
    pkg install -y metasploit
    pkg install -y nikto
    pkg install -y whatweb
    pkg install -y netcat
    pkg install -y git
    pkg install -y python
    pkg install -y python-pip
    pkg install -y curl
    pkg install -y wget
    pkg install -y openssl
    pkg install -y openssh
    pkg install -y proxychains-ng
    pkg install -y tor
    pkg install -y crunch
    pkg install -y john
    pkg install -y binutils
    pkg install -y dnsutils
    pkg install -y whois
    pkg install -y figlet
    pkg install -y toilet
    
    echo -e "${GREEN}[+] Package installation completed${NC}"
}

# Additional tool installations (manual)
install_additional_tools() {
    echo -e "${YELLOW}[+] Installing additional tools...${NC}"
    
    # Install wifite
    if [ ! -d "$HOME/wifite2" ]; then
        cd $HOME
        git clone https://github.com/derv82/wifite2.git
        cd wifite2
        chmod +x Wifite.py
    fi
    
    # Install routersploit
    if [ ! -d "$HOME/routersploit" ]; then
        cd $HOME
        git clone https://github.com/threat9/routersploit.git
        cd routersploit
        pip install -r requirements.txt
    fi
    
    echo -e "${GREEN}[+] Additional tool installation completed${NC}"
}

# Port scanning with Nmap
nmap_scan() {
    read -p "Enter target IP/hostname: " target
    echo -e "${YELLOW}[+] Select scan type:${NC}"
    echo "1) Basic scan"
    echo "2) Full port scan"
    echo "3) Service detection"
    echo "4) OS detection"
    echo "5) Vulnerability scan"
    
    read -p "Enter choice [1-5]: " choice
    
    case $choice in
        1) nmap $target ;;
        2) nmap -p- $target ;;
        3) nmap -sV $target ;;
        4) nmap -O $target ;;
        5) nmap --script vuln $target ;;
        *) echo -e "${RED}[!] Invalid option${NC}" ;;
    esac
}

# Web application scanning
web_scan() {
    echo -e "${YELLOW}[+] Web Application Scanning${NC}"
    echo "1) Nikto scan"
    echo "2) WhatWeb scan"
    echo "3) SQLMap scan"
    
    read -p "Enter choice [1-3]: " choice
    read -p "Enter target URL: " url
    
    case $choice in
        1) nikto -h $url ;;
        2) whatweb $url ;;
        3) sqlmap -u $url --batch --crawl=3 ;;
        *) echo -e "${RED}[!] Invalid option${NC}" ;;
    esac
}

# Password attacks
password_attack() {
    echo -e "${YELLOW}[+] Password Attacks${NC}"
    echo "1) Hydra SSH brute force"
    echo "2) Hydra FTP brute force"
    echo "3) John the Ripper"
    echo "4) Generate wordlist with Crunch"
    
    read -p "Enter choice [1-4]: " choice
    
    case $choice in
        1) 
            read -p "Enter target IP: " target
            read -p "Enter username: " user
            read -p "Enter wordlist path (or press enter for default): " wordlist
            if [ -z "$wordlist" ]; then
                wordlist="/data/data/com.termux/files/usr/share/wordlists/password.lst"
            fi
            hydra -l $user -P $wordlist ssh://$target
            ;;
        2) 
            read -p "Enter target IP: " target
            read -p "Enter username: " user
            read -p "Enter wordlist path (or press enter for default): " wordlist
            if [ -z "$wordlist" ]; then
                wordlist="/data/data/com.termux/files/usr/share/wordlists/password.lst"
            fi
            hydra -l $user -P $wordlist ftp://$target
            ;;
        3)
            read -p "Enter hash file path: " hashfile
            john $hashfile
            ;;
        4)
            read -p "Enter minimum length: " min
            read -p "Enter maximum length: " max
            read -p "Enter character set (e.g., abcd1234): " charset
            read -p "Enter output file name: " output
            crunch $min $max $charset -o $output
            ;;
        *) echo -e "${RED}[!] Invalid option${NC}" ;;
    esac
}

# Network utilities
network_utils() {
    echo -e "${YELLOW}[+] Network Utilities${NC}"
    echo "1) Netcat listener"
    echo "2) Netcat connect"
    echo "3) Port forwarding"
    echo "4) Network interfaces"
    echo "5) DNS lookup"
    echo "6) Whois lookup"
    
    read -p "Enter choice [1-6]: " choice
    
    case $choice in
        1)
            read -p "Enter port to listen on: " port
            nc -l -p $port
            ;;
        2)
            read -p "Enter target IP: " target
            read -p "Enter target port: " port
            nc $target $port
            ;;
        3)
            read -p "Enter local port: " lport
            read -p "Enter remote host: " rhost
            read -p "Enter remote port: " rport
            echo "Forwarding local port $lport to $rhost:$rport via SSH..."
            ssh -L $lport:$rhost:$rport user@$rhost
            ;;
        4) ip addr show ;;
        5) 
            read -p "Enter domain: " domain
            dig $domain
            ;;
        6)
            read -p "Enter domain: " domain
            whois $domain
            ;;
        *) echo -e "${RED}[!] Invalid option${NC}" ;;
    esac
}

# Exploitation tools
exploitation_tools() {
    echo -e "${YELLOW}[+] Exploitation Tools${NC}"
    echo "1) Metasploit Framework"
    echo "2) RouterSploit"
    echo "3) WiFi Testing (Wifite)"
    
    read -p "Enter choice [1-3]: " choice
    
    case $choice in
        1) msfconsole ;;
        2) 
            if [ -d "$HOME/routersploit" ]; then
                cd $HOME/routersploit
                python rsf.py
            else
                echo -e "${RED}[!] RouterSploit not installed. Install it from main menu.${NC}"
            fi
            ;;
        3)
            if [ -d "$HOME/wifite2" ]; then
                cd $HOME/wifite2
                python Wifite.py
            else
                echo -e "${RED}[!] Wifite not installed. Install it from main menu.${NC}"
            fi
            ;;
        *) echo -e "${RED}[!] Invalid option${NC}" ;;
    esac
}

# Information gathering
info_gathering() {
    echo -e "${YELLOW}[+] Information Gathering${NC}"
    echo "1) Whois lookup"
    echo "2) DNS enumeration"
    echo "3) Subdomain enumeration"
    echo "4) Network scanning"
    
    read -p "Enter choice [1-4]: " choice
    
    case $choice in
        1)
            read -p "Enter domain: " domain
            whois $domain
            ;;
        2)
            read -p "Enter domain: " domain
            nslookup $domain
            dig $domain
            ;;
        3)
            read -p "Enter domain: " domain
            echo -e "${YELLOW}[+] Using Sublist3r for subdomain enumeration...${NC}"
            if [ ! -d "$HOME/Sublist3r" ]; then
                cd $HOME
                git clone https://github.com/aboul3la/Sublist3r.git
                cd Sublist3r
                pip install -r requirements.txt
            fi
            cd $HOME/Sublist3r
            python sublist3r.py -d $domain
            ;;
        4)
            read -p "Enter network range (e.g., 192.168.1.0/24): " network
            nmap -sn $network
            ;;
        *) echo -e "${RED}[!] Invalid option${NC}" ;;
    esac
}

# Anonymity tools
anonymity_tools() {
    echo -e "${YELLOW}[+] Anonymity Tools${NC}"
    echo "1) Start Tor service"
    echo "2) Stop Tor service"
    echo "3) Check Tor status"
    echo "4) Update ProxyChains config"
    
    read -p "Enter choice [1-4]: " choice
    
    case $choice in
        1)
            echo -e "${YELLOW}[+] Starting Tor service...${NC}"
            tor &
            echo -e "${GREEN}[+] Tor started${NC}"
            ;;
        2)
            echo -e "${YELLOW}[+] Stopping Tor service...${NC}"
            pkill tor
            echo -e "${GREEN}[+] Tor stopped${NC}"
            ;;
        3)
            echo -e "${YELLOW}[+] Checking Tor status...${NC}"
            if pgrep tor > /dev/null; then
                echo -e "${GREEN}[+] Tor is running${NC}"
            else
                echo -e "${RED}[!] Tor is not running${NC}"
            fi
            ;;
        4)
            echo -e "${YELLOW}[+] Updating ProxyChains configuration...${NC}"
            echo "socks5 127.0.0.1 9050" >> $PREFIX/etc/proxychains.conf
            echo -e "${GREEN}[+] ProxyChains updated${NC}"
            ;;
        *) echo -e "${RED}[!] Invalid option${NC}" ;;
    esac
}

# Main menu function
show_menu() {
    echo -e "${BLUE}==================================${NC}"
    echo -e "${BLUE}    Termux Pentesting Toolkit     ${NC}"
    echo -e "${BLUE}==================================${NC}"
    echo "1) Install required packages"
    echo "2) Install additional tools"
    echo "3) Port scanning (Nmap)"
    echo "4) Web application scanning"
    echo "5) Password attacks"
    echo "6) Network utilities"
    echo "7) Exploitation tools"
    echo "8) Information gathering"
    echo "9) Anonymity tools"
    echo "10) Exit"
    echo ""
    read -p "Select an option [1-10]: " option
    
    case $option in
        1) install_packages ;;
        2) install_additional_tools ;;
        3) nmap_scan ;;
        4) web_scan ;;
        5) password_attack ;;
        6) network_utils ;;
        7) exploitation_tools ;;
        8) info_gathering ;;
        9) anonymity_tools ;;
        10) exit 0 ;;
        *) 
            echo -e "${RED}[!] Invalid option. Please try again.${NC}"
            sleep 2
            ;;
    esac
}

# Main execution
main() {
    check_termux
    show_banner
    
    # Main loop
    while true; do
        show_menu
        echo ""
        read -p "Press Enter to continue..."
    done
}

# Run the script
main
