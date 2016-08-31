#!/bin/bash
# SHatomATOR v0.5
# Made by Dr. Waldijk
# Installs & Upgrades Atom Editor on Fedora.
# Read the README.md for more info.
# By running this script you agree to the license terms.
# -----------------------------------------------------------------------------------
echo "Checking..."
# Check if Atom is installed, if yes then check if upgrade is available, if no then install.
if [ -e /bin/atom ]
then
    # Download, upgrade & remove d/l file
    # Fetch latest version URL for Atom Editor.
    atomurl=$(curl -ILs -o /dev/null -w %{url_effective} https://github.com/atom/atom/releases/latest)
    # Same as above, but regex out the version.
    atomlatest=$(curl -ILs -o /dev/null -w %{url_effective} https://github.com/atom/atom/releases/latest | egrep -o '([0-9]{1,2}\.)*[0-9]{1,2}')
    # Fetch version of installed Atom Editor.
    atominstalled=$(dnf info atom --cacheonly | grep Version | egrep -o '([0-9]{1,2}\.)*[0-9]{1,2}')
    if [ "$atomlatest" != "$atominstalled" ]
    then
        atomrpm=$(echo "atom.x86_64.rpm")
        atomdownload=$(echo "https://github.com/atom/atom/releases/download/v")
        wget -q --show-progress $atomdownload$atomlatest/$atomrpm -P /tmp/
        sudo dnf -y upgrade /tmp/$atomrpm
        rm /tmp/$atomrpm
    else
        echo "You already have the latest version of Atom Editor v$atomlatest installed."
    fi
else
    clear
    echo "Installing Atom Editor..."
    wget -q --show-progress $atomdownload$atomlatest/$atomrpm -P /tmp/
    sudo dnf -y install /tmp/$atomrpm
    rm /tmp/$atomrpm
fi
