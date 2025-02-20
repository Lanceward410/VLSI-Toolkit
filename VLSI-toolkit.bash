#!/bin/bash

GREEN='\033[32m'
RED='\033[31m'
DEFAULT='\033[0m'
set -e
trap 'echo "${RED}Error on line $LINENO: $BASH_COMMAND ${DEFAULT}" >&2' ERR

echo "${GREEN}Updating system packages...${DEFAULT}"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt --fix-broken install -y

echo "${GREEN}Installing dependencies...${DEFAULT}"
sudo apt install -y build-essential python3 python3-venv python3-pip python3-tk \
    ca-certificates curl make git gedit mesa-utils x11-apps x11-utils bison flex \
    tcl tcl-dev tk tk-dev libxpm4 libxpm-dev xterm magic ngspice

echo "${GREEN}Installing Xschem...${DEFAULT}"
if [ ! -d "$HOME/xschem-src" ]; then
    git clone https://github.com/StefanSchippers/xschem.git ~/xschem-src
fi
cd ~/xschem-src
git pull
./configure --prefix=new/prefix/path
make -j$(nproc)
sudo make install
cd ~

echo "${GREEN}Installing Docker for OpenLane...${DEFAULT}"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "${GREEN}Adding user to Docker group...${DEFAULT}"
sudo groupadd -f docker
sudo usermod -aG docker $USER
newgrp docker

echo "${GREEN}Cloning and updating OpenLane...${DEFAULT}"
if [ ! -d "$HOME/OpenLane" ]; then
    git clone https://github.com/The-OpenROAD-Project/OpenLane ~/OpenLane
fi
cd ~/OpenLane
git pull
make -j$(nproc)
