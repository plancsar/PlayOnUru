#!/bin/bash
# A script to install Uru CC Drizzle on macOS using the 25th Anniv. Edition.
# -- Korov'ev, 2020-06-13

URU_DIR="Uru Complete Chronicles.app/Contents/SharedSupport/uru_cc/support/uru/drive_c/URU-CC"
CC_DIR="Uru CC Drizzle.app/Contents/Resources/drive_c/Program Files/"
SAV_DIR="$HOME/Library/Application Support/Uru Complete Chronicles/Bottles/uru/drive_c/URU-CC/sav"

echo -e "\nCopying game folder from the 25th Anniversary Uru CC ..."
cp -r "$URU_DIR" "$CC_DIR"
cp -r "$SAV_DIR" "$CC_DIR/URU-CC/"


cd "$CC_DIR"
mv drizzle32.zip UruCCBeta.zip URU-CC/
cd URU-CC

unzip -o UruCCBeta.zip && rm UruCCBeta.zip
mv UruCCBeta/Readme.txt  UruCCBeta/Readme114.txt
cp UruCCBeta/* .
rm -r UruCCBeta

unzip -o drizzle32.zip && rm drizzle32.zip
cp Uru/dat/*     dat/
cp Uru/python/*  Python/
cp Uru/sdl/*     SDL/

mkdir $HOME/bin
chmod 755 Drizzle32.jar
cp Drizzle32.jar $HOME/bin/
rm -r Uru Drizzle32.jar

echo -e "\nPatching done. You can test the wrapper.\nHave fun!\n"
