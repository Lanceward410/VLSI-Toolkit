#!/bin/bash

set -e
trap 'echo "Error on line $LINENO: $BASH_COMMAND" >&2' ERR

echo "Updating system packages..."
sudo apt-get update && sudo apt-get upgrade -y
sudo apt --fix-broken install -y

echo "Installing dependencies..."
sudo apt install -y build-essential python3 python3-venv python3-pip python3-tk \
    ca-certificates curl make git gedit mesa-utils x11-apps x11-utils bison flex \
    tcl tcl-dev tk tk-dev libxpm4 libxpm-dev xterm magic ngspice

echo "Installing Xschem..."
if [ ! -d "$HOME/xschem-src" ]; then
    git clone https://github.com/StefanSchippers/xschem.git ~/xschem-src
fi
cd ~/xschem-src
git pull
./configure --prefix=new/prefix/path
make -j$(nproc)
sudo make install
cd ~

echo "Installing Docker for OpenLane..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "Adding user to Docker group..."
sudo groupadd -f docker
sudo usermod -aG docker $USER
exec newgrp docker
