#!/bin/bash
# A basic script to install MOULa and shards on linux.
# It assumes a recent version of Wine (from WineHQ) and winetricks are already installed.
# -- Korov'ev, 2020-02-18

SHARDPREFIX=$HOME/uru-live

if [ ! -f "MOULInstaller.exe" ]; then
	wget http://account.mystonline.com/download/MOULInstaller.exe
	chmod 755 MOULInstaller.exe
fi

WINEARCH=win32 WINEPREFIX=$SHARDPREFIX winetricks vcrun6 physx
WINEPREFIX=$SHARDPREFIX wine start /unix $HOME/MOULInstaller.exe

echo 'alias urulive="WINEPREFIX=$HOME/uru-live wine start /unix $HOME/uru-live/drive_c/Program\ Files/Uru\ Live/UruLauncher.exe"' >> $HOME/.bashrc

# The game will launch and start downloading stuff; it's probably better to let it finish.
# Let the Launcher install PhysX. dxwebsetup will crash, but it's already installed.
#
# Use the following to launch the shard (or set an alias in .bashrc):
#
#   WINEPREFIX=$HOME/uru-live wine start /unix $HOME/uru-live/drive_c/Program\ Files/Uru\ Live/UruLauncher.exe
#
# If you modified $SHARDPREFIX, remember to also change the above command accordingly.



read -n 1 -s -r -p "Press any key to continue"
SHARDPREFIX=$HOME/uru-gehn

if [ ! -f "gehn_shard.exe" ]; then
	wget https://guildofwriters.org/cwe/gehn_shard.exe
	chmod 755 gehn_shard.exe
fi

WINEARCH=win32 WINEPREFIX=$SHARDPREFIX winetricks vcrun2015 d3dx10

cp -r $HOME/uru-live/drive_c/Program\ Files/Uru\ Live $SHARDPREFIX/drive_c/Program\ Files/
mv $SHARDPREFIX/drive_c/Program\ Files/Uru\ Live $SHARDPREFIX/drive_c/Program\ Files/Gehn\ shard

WINEPREFIX=$SHARDPREFIX wine start /unix $HOME/gehn_shard.exe

echo 'alias gehnshard="WINEPREFIX=$HOME/uru-gehn wine start /unix $HOME/uru-gehn/drive_c/Program\ Files/Gehn\ Shard/UruLauncher.exe"' >> $HOME/.bashrc

# Fixing PhysX on MOUL
WINEPREFIX=$HOME/uru-live wine start /unix $HOME/uru-gehn/drive_c/Program\ Files/Gehn\ Shard/PhysX_Setup.exe



read -n 1 -s -r -p "Press any key to continue"
SHARDPREFIX=$HOME/uru-toc

if [ ! -f "TOC-Moul.exe" ]; then
	wget http://other.the-open-cave.net/installer/TOC-Moul.exe
	chmod 755 TOC-Moul.exe
fi

WINEARCH=win32 WINEPREFIX=$SHARDPREFIX winetricks vcrun2013 d3dx10

cp -r $HOME/uru-live/drive_c/Program\ Files/Uru\ Live $SHARDPREFIX/drive_c/Program\ Files/
mv $SHARDPREFIX/drive_c/Program\ Files/Uru\ Live $SHARDPREFIX/drive_c/Program\ Files/TOC-Moul

WINEPREFIX=$SHARDPREFIX wine start /unix $HOME/TOC-Moul.exe

echo 'alias opencave="WINEPREFIX=$HOME/uru-toc wine start /unix $HOME/uru-toc/drive_c/Program\ Files/TOC-Moul/UruLauncher.exe"' >> $HOME/.bashrc



read -n 1 -s -r -p "Press any key to continue"
SHARDPREFIX=$HOME/uru-minkata

WINEARCH=win32 WINEPREFIX=$SHARDPREFIX winetricks vcrun6 physx

cp -r $HOME/uru-live/drive_c/Program\ Files/Uru\ Live $SHARDPREFIX/drive_c/Program\ Files/
mv $SHARDPREFIX/drive_c/Program\ Files/Uru\ Live $SHARDPREFIX/drive_c/Program\ Files/Minkata

cd $SHARDPREFIX/drive_c/Program\ Files/Minkata/
rm UruLauncher.exe
wget http://foundry.openuru.org/jenkins/job/CWE-ou-minkata-Compile/lastSuccessfulBuild/BuildType=External,Platform=Windows2k3Builder/artifact/MOULOpenSourceClientPlugin/Plasma20/MsDevProjects/Plasma/Apps/plUruLauncher/Release/UruLauncher.exe
chmod 755 UruLauncher.exe

WINEPREFIX=$SHARDPREFIX wine start /unix $HOME/UruLauncher.exe

echo 'alias minkata="WINEPREFIX=$HOME/uru-minkata wine start /unix $HOME/uru-minkata/drive_c/Program\ Files/Minkata/UruLauncher.exe"' >> $HOME/.bashrc

# Fixing PhysX on Minkata
WINEPREFIX=$HOME/uru-minkata wine start /unix $HOME/uru-gehn/drive_c/Program\ Files/Gehn\ Shard/PhysX_Setup.exe
