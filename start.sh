#!/bin/bash
# SHatomATOR v0.6
# Made by Dr. Waldijk
# Installs & Upgrades Atom Editor on Fedora.
# Read the README.md for more info.
# By running this script you agree to the license terms.
# -----------------------------------------------------------------------------------
echo "Checking..."
ATOMRPM="atom.x86_64.rpm"
ATOMDOWNLOAD="https://github.com/atom/atom/releases/download/v"
# Fetch latest version URL for Atom Editor.
ATOMURL=$(curl -ILs -o /dev/null -w %{url_effective} https://github.com/atom/atom/releases/latest)
# Same as above, but regex out the version.
ATOMLATEST=$(curl -ILs -o /dev/null -w %{url_effective} https://github.com/atom/atom/releases/latest | egrep -o '([0-9]{1,2}\.)*[0-9]{1,2}')
# Check if Atom is installed, if yes then check if upgrade is available, if no then install.
if [ -e /bin/atom ]
then
    # Fetch version of installed Atom Editor.
    ATOMINSTALLED=$(dnf info atom --cacheonly | grep Version | egrep -o '([0-9]{1,2}\.)*[0-9]{1,2}')
    if [ "$ATOMLATEST" != "$ATOMINSTALLED" ]
    then
        # Download, upgrade & remove d/l file
        wget -q --show-progress $ATOMDOWNLOAD$ATOMLATEST/$ATOMRPM -P /tmp/
        sudo dnf -y upgrade /tmp/$ATOMRPM
        rm /tmp/$ATOMRPM
    else
        echo "You already have the latest version of Atom Editor v$ATOMLATEST installed."
    fi
else
    clear
    echo "Installing Atom Editor..."
    wget -q --show-progress $ATOMDOWNLOAD$ATOMLATEST/$ATOMRPM -P /tmp/
    sudo dnf -y install /tmp/$ATOMRPM
    rm /tmp/$ATOMRPM
    atomupgradealias=$(pwd)
    echo "alias atomupgrade='$atomupgradealias/start.sh'" >> ~/.bashrc
fi
