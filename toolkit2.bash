#!/bin/bash

set -e
trap 'echo "Error on line $LINENO: $BASH_COMMAND" >&2' ERR

cd ~
echo "Cloning and updating OpenLane..."
if [ ! -d "$HOME/OpenLane" ]; then
    git clone https://github.com/The-OpenROAD-Project/OpenLane ~/OpenLane
fi
cd ~/OpenLane
git pull
make
