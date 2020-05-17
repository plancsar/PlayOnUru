#!/bin/bash
# A basic script to install Deep Island on linux.
# It assumes a recent version of Wine (from WineHQ) and winetricks are already installed.
# -- Korov'ev, 2020-02-18

INSTALLDIR="$HOME/uru-installers"

if [[ "$OSTYPE" == "darwin"* ]]; then
    BASHFILE=".profile"
else
    BASHFILE=".bashrc"
fi

mkdir -p "$INSTALLDIR" && cd "$INSTALLDIR"

# ================= Uru: Complete Chronicles =================

echo "Installing Uru: Complete Chronicles..."
SHARDPREFIX="$HOME/uru-deepisland"

echo "Where is the GOG Uru:CC installer?"
read -e GOGPATH
GOGPATH=$(readlink -f $GOGPATH)

chmod 755 $GOGPATH

WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun6 >> $HOME/uru-wine.log 2>&1
WINEPREFIX="$SHARDPREFIX" wine start /unix "$GOGPATH" >> $HOME/uru-wine.log 2>&1

read -n 1 -s -r -p "
Advance the installer with the mouse, the keyboard may be intercepted by the script.
When the installation is done, press any key to continue.
"

cd "$SHARDPREFIX/drive_c/GOG Games/Myst Uru Complete Chronicles/"
curl -L -o Drizzle31.jar "https://downloads.sourceforge.net/project/drizzle/Drizzle31.jar?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fdrizzle%2Ffiles%2Flatest%2Fdownload&ts=1582060033"

mv "$SHARDPREFIX/drive_c/GOG Games/Myst Uru Complete Chronicles" "$SHARDPREFIX/drive_c/Program Files/Deep Island"

# ================= Deep Island =================

echo "Installing Deep Island..."

cd "$SHARDPREFIX/drive_c/Program Files/Deep Island"
curl -L -O "http://www.the-deep-island.de/shard/di-patcher.zip"
rm msvcp60.dll
unzip di-patcher.zip && rm di-patcher.zip

WINEPREFIX="$SHARDPREFIX" wine start /unix "$SHARDPREFIX/drive_c/Program Files/Deep Island/Uru.exe" >> $HOME/uru-wine.log 2>&1

# ================= aliases =================

while true; do
    read -p "Do you wish to add the 'drizzle' and 'deepisland' aliases to $BASHFILE ? [y/n] " yn
    case $yn in
        [Yy]* )
            echo 'alias drizzle="java -jar $HOME/uru-deepisland/drive_c/Program\ Files/Deep\ Island/Drizzle31.jar"' >> $HOME/$BASHFILE
            echo 'alias deepisland="WINEPREFIX=$HOME/uru-deepisland wine start /unix $HOME/uru-deepisland/drive_c/Program\ Files/Deep\ Island/Uru.exe"' >> $HOME/$BASHFILE
            break;;
        [Nn]* ) break;;
        * ) break;;
    esac
done


echo -e "If the shard works correctly, you can delete the uru-installers folder.\nHave fun!"

