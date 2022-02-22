#!/bin/bash
# A script to install Deep Island on macOS using the 25th Anniv. Edition.
# -- Korov'ev, 2020-06-13

URU_DIR="Uru Complete Chronicles.app/Contents/SharedSupport/uru_cc/support/uru/drive_c/URU-CC"
DI_DIR="Deep Island.app/Contents/Resources/drive_c/Program Files/"

echo -e "\nCopying game folder from the 25th Anniversary Uru CC ..."
cp -r "$URU_DIR" "$DI_DIR"/

cd "$DI_DIR"

chmod 755 Drizzle31.jar
mkdir $HOME/bin
cp Drizzle31.jar $HOME/bin/
rm Drizzle31.jar

mv di-patcher.zip URU-CC/
cd URU-CC
unzip -o di-patcher.zip && rm di-patcher.zip

echo -e "\nPatching done. You can test the wrapper.\nHave fun!\n"
