#!/bin/bash
# SHatomATOR v0.2
# Upgrades Atom Editor on RPM systems.
# Written by Dr. Waldijk
# Read the README.md for more info.
# -----------------------------------------------------------------------------------
echo "Checking..."
# Fetch latest version URL for Atom Editor.
atomurl=$(curl -ILs -o /dev/null -w %{url_effective} https://github.com/atom/atom/releases/latest)
# Same as above, but regex out the version.
atomlatest=$(curl -ILs -o /dev/null -w %{url_effective} https://github.com/atom/atom/releases/latest | egrep -o '([0-9]\.)*[0-9]')
# Fetch version of installed Atom Editor.
atominstalled=$(dnf info atom --cacheonly | grep Version | egrep -o '([0-9]\.)*[0-9]')
atomrpm=$(echo "atom.x86_64.rpm")
atomdownload=$(echo "https://github.com/atom/atom/releases/download/v")
# Check if version is equal, if not, then upgrade; if so, then do nothing.
if [ -e /bin/atom ]
then
    if [ "$atomlatest" != "$atominstalled" ]
    then
        # Download, upgrade & remove d/l file
        wget -q --show-progress $atomdownload$atomlatest/$atomrpm -P /tmp/
        sudo dnf -y upgrade /tmp/$atomrpm
        rm /tmp/$atomrpm
    else
        echo "You already have the latest version of Atom Editor v$atomlatest installed."
    fi
else
    wget -q --show-progress $atomdownload$atomlatest/$atomrpm -P /tmp/
    sudo dnf -y upgrade /tmp/$atomrpm
    rm /tmp/$atomrpm
fi
