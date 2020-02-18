#!/bin/bash
# A basic script to install MOULa and shards on linux.
# It assumes a recent version of Wine (from WineHQ) and winetricks are already installed.
# -- Korov'ev, 2020-02-18

INSTALLDIR="$HOME/uru-installers"

mkdir -p "$INSTALLDIR" && cd "$INSTALLDIR"

# ================= Uru Live =================

echo "Installing Myst Online: Uru Live..."
SHARDPREFIX="$HOME/uru-live"

if [ ! -f "MOULInstaller.exe" ]; then
    echo "Downloading the installer..."
    curl -L -O "http://account.mystonline.com/download/MOULInstaller.exe"
    chmod 755 MOULInstaller.exe
fi

WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun6 >> $HOME/uru-wine.log 2>&1
WINEPREFIX="$SHARDPREFIX" wine start /unix "$INSTALLDIR/MOULInstaller.exe" >> $HOME/uru-wine.log 2>&1

# The game will launch and start downloading stuff; it's probably better to let it finish.
# Let the installer launch the game.
# Let the Launcher install PhysX. dxwebsetup will crash, but it's already installed.
# Use the following to launch the shard (or set an alias in .bashrc):
#
#   WINEPREFIX="$HOME/uru-live" wine start /unix "$HOME/uru-live/drive_c/Program Files/Uru Live/UruLauncher.exe"
#
# If you modified $SHARDPREFIX, remember to also change the above command accordingly.

read -n 1 -s -r -p "
Advance the installer with the mouse, the keyboard may be intercepted by the script.
When the installation is done, press any key to continue.
"

# ================= Gehn shard =================

echo "Installing the Gehn shard..."
SHARDPREFIX="$HOME/uru-gehn"

if [ ! -f "gehn_shard.exe" ]; then
    echo "Downloading the installer..."
    curl -L -O "https://guildofwriters.org/cwe/gehn_shard.exe"
    chmod 755 gehn_shard.exe
fi

WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun2015 d3dx10 >> $HOME/uru-wine.log 2>&1
echo "Copying MOUL files..."
cp -r "$HOME/uru-live/drive_c/Program Files/Uru Live" "$SHARDPREFIX/drive_c/Program Files/"
mv "$SHARDPREFIX/drive_c/Program Files/Uru Live" "$SHARDPREFIX/drive_c/Program Files/Gehn shard"

WINEPREFIX="$SHARDPREFIX" wine start /unix "$INSTALLDIR/gehn_shard.exe" >> $HOME/uru-wine.log 2>&1
read -n 1 -s -r -p "
Advance the installer with the mouse, the keyboard may be intercepted by the script.
When the installation is done, press any key to continue.
"

# ================= The Open Cave =================

echo "Installing the Open Cave shard..."
SHARDPREFIX="$HOME/uru-toc"

if [ ! -f "TOC-Moul.exe" ]; then
    echo "Downloading the installer..."
    curl -L -O "http://other.the-open-cave.net/installer/TOC-Moul.exe"
    chmod 755 TOC-Moul.exe
fi

WINEARCH=win32 WINEPREFIX=$SHARDPREFIX winetricks vcrun2013 d3dx10 >> $HOME/uru-wine.log 2>&1
echo "Copying MOUL files..."
cp -r $HOME/uru-live/drive_c/Program Files/Uru Live $SHARDPREFIX/drive_c/Program Files/
mv $SHARDPREFIX/drive_c/Program Files/Uru Live $SHARDPREFIX/drive_c/Program Files/TOC-Moul

WINEPREFIX=$SHARDPREFIX wine start /unix $INSTALLDIR/TOC-Moul.exe >> $HOME/uru-wine.log 2>&1
read -n 1 -s -r -p "
Advance the installer with the mouse, the keyboard may be intercepted by the script.
When the installation is done, press any key to continue.
"

# ================= Minkata =================

echo "Installing the Minkata testing shard..."
SHARDPREFIX=$HOME/uru-minkata

WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun6 >> $HOME/uru-wine.log 2>&1
echo "Copying MOUL files..."
cp -r "$HOME/uru-live/drive_c/Program Files/Uru Live" "$SHARDPREFIX/drive_c/Program Files/"
mv "$SHARDPREFIX/drive_c/Program Files/Uru Live" "$SHARDPREFIX/drive_c/Program Files/Minkata"

cd "$SHARDPREFIX/drive_c/Program Files/Minkata/"
rm UruLauncher.exe

echo "Downloading the installer..."
curl -L -O "https://foundry.openuru.org/jenkins/job/CWE-ou-minkata-Compile/lastSuccessfulBuild/BuildType=External,Platform=Windows2k3Builder/artifact/MOULOpenSourceClientPlugin/Plasma20/MsDevProjects/Plasma/Apps/plUruLauncher/Release/UruLauncher.exe"
chmod 755 UruLauncher.exe

WINEPREFIX="$SHARDPREFIX" wine start /unix "$SHARDPREFIX/drive_c/Program Files/Minkata/UruLauncher.exe" >> $HOME/uru-wine.log 2>&1
read -n 1 -s -r -p "
Advance the installer with the mouse, the keyboard may be intercepted by the script.
When the installation is done, press any key to continue.
"

# ================= PhysX =================

echo "Fixing PhysX for MOUL and Minkata..."
WINEPREFIX="$HOME/uru-live" wine start /unix "$HOME/uru-gehn/drive_c/Program Files/Gehn Shard/PhysX_Setup.exe" >> $HOME/uru-wine.log 2>&1
WINEPREFIX="$HOME/uru-minkata" wine start /unix "$HOME/uru-gehn/drive_c/Program Files/Gehn Shard/PhysX_Setup.exe" >> $HOME/uru-wine.log 2>&1
read -n 1 -s -r -p "
Advance the installer with the mouse, the keyboard may be intercepted by the script.
When the installation is done, press any key to continue.
"

# ================= aliases =================

while true; do
    read -p 'Do you wish to add the "urulive", "gehnshard", "opencave" and "minkata" aliases to .bashrc ? [y/n]' yn
    case $yn in
        [Yy]* )
            echo 'alias urulive="WINEPREFIX=$HOME/uru-live wine start /unix $HOME/uru-live/drive_c/Program\ Files/Uru\ Live/UruLauncher.exe"' >> $HOME/.bashrc
            echo 'alias gehnshard="WINEPREFIX=$HOME/uru-gehn wine start /unix $HOME/uru-gehn/drive_c/Program\ Files/Gehn\ Shard/UruLauncher.exe"' >> $HOME/.bashrc
            echo 'alias gehnshard-repair="WINEPREFIX=$HOME/uru-gehn wine start /unix $HOME/uru-gehn/drive_c/Program\ Files/Gehn\ Shard/UruLauncher.exe /ServerIni=repair.ini /Repair"' >> $HOME/.bashrc
            echo 'alias opencave="WINEPREFIX=$HOME/uru-toc wine start /unix $HOME/uru-toc/drive_c/Program\ Files/TOC-Moul/UruLauncher.exe"' >> $HOME/.bashrc
            echo 'alias opencave-repair="WINEPREFIX=$HOME/uru-toc wine start /unix $HOME/uru-toc/drive_c/Program\ Files/TOC-Moul/UruLauncher.exe /ServerIni=repair.ini /Repair"' >> $HOME/.bashrc
            echo 'alias minkata="WINEPREFIX=$HOME/uru-minkata wine start /unix $HOME/uru-minkata/drive_c/Program\ Files/Minkata/UruLauncher.exe"' >> $HOME/.bashrc
            break;;
        [Nn]* ) break;;
        * ) break;;
    esac
done


echo -e "If the shards work correctly, you can delete the uru_installers folder.\nHave fun!"
