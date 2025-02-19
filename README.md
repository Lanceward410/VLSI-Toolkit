# VLSI-Toolkit
VLSI WSL Toolkit

instructions for use:
Either install WSL via Windows App store,
Or in Windows Powershell, install via:

    wsl --install

Then,
Open Windows Powershell:

    wsl --update
    wsl --shutdown

Finally, You may access "Ubuntu" from the Windows App Store. This opens a terminal,
which should be Ubuntu 24.04, and you'll need to configure your Ubuntu OS with
a username + password, just like you would on any new PC.

'wsl' is to be called from Windows Powershell, but all other functions you do in Linux
should be done within the Ubuntu (Linux) terminal.

When booting up Ubuntu/WSL, always run "sudo apt update" and "sudo apt upgrade",
it prevents issues; it is comparable to flossing.

~
Next, to use this VLSI-toolkit quick installation, you can run (via copy/paste if you wish):

    sudo apt update
    sudo apt upgrade -y
    sudo apt install git -y
    cd ~
    git clone https://github.com/LanceWard410/VLSI-Toolkit.git
    cd ~/VLSI-Toolkit
    bash VLSI-toolkit.bash

Note that everything in Linux is case sensitive.

After the VLSI-toolkit.bash script runs, you will need to reboot Ubuntu, so go back to Windows Powershell:

    wsl --shutdown

And finally, re-open Ubuntu from the Windows App Store, and enter into the Ubuntu terminal:

    cd ~/OpenLane
    make

~

Help with Magic: https://web02.gonzaga.edu/faculty/talarico/vlsi/magic.html

Help with Xschem: http://repo.hu/projects/xschem/xschem_man/install_xschem.html

Help with OpenLane: https://github.com/AnoushkaTripathi/Openlane_Installation_guide
