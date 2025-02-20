#!bin/bash

# Magic, NGSPICE, Icarus Verilog, GTKWave
# Other dependencies are numerous
sudo apt-get update && sudo apt-get upgrade -y
sudo apt --fix-broken install
sudo apt update
sudo apt install build-essential python3 python3-venv python3-pip python3-tk ca-certificates curl make git gedit mesa-utils x11-apps x11-utils bison flex tx1 tcl-dev tk tk-dev libxpm4 libxpm-dev xterm -y
sudo apt install magic ngspice -y

# Xschem installs from source code
cd ~/xschem-src
./configure
make
sudo make install
./configure --prefix=new/prefix/path
cd ~

# OpenLane requires Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER
sudo apt-get update
sudo apt-get upgrade
cd ~
git clone https://github.com/The-OpenROAD-Project/OpenLane

# At this stage, you have to either reboot Ubuntu (if not running WSL),
# Or enter Powershell on host and run   wsl --shutdown   and then you can
# Go to   cd ~/OpenLane   and run the command:   make
