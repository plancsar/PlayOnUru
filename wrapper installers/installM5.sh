#!/bin/bash
# A script to install Myst V on macOS using the 25th Anniv. Edition.
# -- Korov'ev, 2023-03-19

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

URU_DIR="Myst V End of Ages Limited Edition.app/Contents/SharedSupport/myst_v/support/myst_v/drive_c/Myst V"
CC_DIR="Myst V.app/Contents/Resources/drive_c/Program Files/"
#CC_DIR="Myst V.app/Contents/SharedSupport/prefix/drive_c/Program Files/"
#SAV_DIR="$HOME/Library/Application Support/Myst V End of Ages/Bottles/myst_v/drive_c/Myst V/save"

echo -e "\nCopying game folder from the 25th Anniversary Myst V ..."
cp -r "$URU_DIR" "$CC_DIR"
#cp -r "$SAV_DIR" "$CC_DIR/Myst 4/"

echo -e "\nPatching done. You can test the wrapper.\nHave fun!\n"
