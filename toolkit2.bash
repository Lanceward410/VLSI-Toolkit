#!bin/bash

set -e
echo "Cloning and updating OpenLane..."
if [ ! -d "$HOME/OpenLane" ]; then
    git clone https://github.com/The-OpenROAD-Project/OpenLane ~/OpenLane
fi
cd ~/OpenLane
git pull
make -j$(nproc)