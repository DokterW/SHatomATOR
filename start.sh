#!/bin/bash
# SHatomATOR v0.1
# Upgrades Atom Editor on RPM systems.
# Written by Dr. Waldijk
# Read the README.md for more info.
#
# Fetch latest version URL for Atom Editor.
atomurl=$(curl -ILs -o /dev/null -w %{url_effective} https://github.com/atom/atom/releases/latest)
# Same as above, but regex out the version.
atomlatest=$(curl -ILs -o /dev/null -w %{url_effective} https://github.com/atom/atom/releases/latest | egrep -o '([0-9]\.)*[0-9]')
# Fetch version of installed Atom Editor.
atominstalled=$(dnf info atom --cacheonly | grep Version | egrep -o '([0-9]\.)*[0-9]')
atomrpm=$(echo "atom.x86_64.rpm")
atomdownload=$(echo "https://github.com/atom/atom/releases/download/v")
# while :
# do
#    echo "info"
    # Check if version is equal, if not, then upgrade; if so, then do nothing.
    if [ "$atomlatest" != "$atominstalled" ]
    then
        # Download, upgrade & remove d/l file
        wget -q --show-progress $atomdownload$atomlatest/$atomrpm
        sudo dnf -y upgrade $atomrpm
        rm atom.x86_64.rpm
    else
        echo "You already have the latest version of Atom Editor v$atomlatest installed."
    fi
# done
