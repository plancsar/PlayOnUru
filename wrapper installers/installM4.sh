#!/bin/bash
# A script to install Myst IV on macOS using the 25th Anniv. Edition.
# -- Korov'ev, 2023-03-19

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

URU_DIR="Myst IV Revelation.app/Contents/SharedSupport/myst_iv/support/myst_iv/drive_c/Myst 4"
CC_DIR="Myst IV.app/Contents/Resources/drive_c/Program Files/"
#CC_DIR="Myst IV.app/Contents/SharedSupport/prefix/drive_c/Program Files/"
SAV_DIR="$HOME/Library/Application Support/Myst IV Revelation/Bottles/myst_iv/drive_c/Myst 4/save"

echo -e "\nCopying game folder from the 25th Anniversary Myst IV ..."
cp -r "$URU_DIR" "$CC_DIR"
cp -r "$SAV_DIR" "$CC_DIR/Myst 4/"

echo -e "\nPatching done. You can test the wrapper.\nHave fun!\n"
