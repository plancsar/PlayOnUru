#!/bin/bash
# A basic script to install the Gehn shard on linux.
# It assumes a recent version of Wine (from WineHQ) is already installed.
# -- Korov'ev, 2017-05-18

GEHNPREFX=$HOME/gehnwine
wget https://guildofwriters.org/cwe/gehn_shard.exe
chmod 755 gehn_shard.exe
wget https://raw.githubusercontent.com/winetricks/winetricks/master/src/winetricks
chmod 755 winetricks
WINEARCH=win32 WINEPREFIX=$GEHNPREFX winecfg   # It might hang in here for a while.
                                               # Set compatibility to Windows 8 (maybe)
WINEPREFIX=$GEHNPREFX $HOME/winetricks vcrun2015 d3dx10
WINEPREFIX=$GEHNPREFX wine start /unix $HOME/gehn_shard.exe

# The game will launch and start downloading stuff; it's probably better to let it finish.
# Let the Launcher install PhysX. dxwebsetup will crash, but it's already installed.
#
# Use the following to launch the shard (or set an alias in .bashrc):
#
#   WINEPREFIX=$HOME/gehnwine wine start /unix $HOME/gehnwine/drive_c/Program\ Files/Gehn\ Shard/UruLauncher.exe
#
# If you modified $GEHNPREFX, remember to also change the above command accordingly.
