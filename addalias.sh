#!/bin/bash
atomupgradealias=$(pwd)
echo "alias atomupgrade='$atomupgradealias/start.sh'" >> ~/.bashrc
rm addalias.sh
