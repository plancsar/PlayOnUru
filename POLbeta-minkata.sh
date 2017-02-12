#!/usr/bin/env playonlinux-bash
# Date: 2017-02-12 13:30 GMT
# Wine version used: 1.7.18
# Distribution used to test: Ubuntu 16.04 LTS 64 (VirtualBox)
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Minkata Shard"
PREFIX="minkata"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "OpenUru.org" "http://openuru.org/" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "1.7.18"
Set_Desktop "On" "1024" "768"

# Copy the game files from the Uru Live prefix and adding Minkata's Launcher
POL_Download "https://github.com/plancsar/PlayOnUru/raw/master/MinkataLauncher.zip"
unzip MinkataLauncher.zip
mkdir $HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/"$TITLE"
mv UruLauncher.exe $HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/"$TITLE"/

cp -r $HOME/.PlayOnLinux/wineprefix/mystonline/drive_c/Program\ Files/Uru\ Live/dat $HOME/.PlayOnLinux/wineprefix/mystonline/drive_c/Program\ Files/Uru\ Live/sfx $HOME/.PlayOnLinux/wineprefix/mystonline/drive_c/Program\ Files/Uru\ Live/avi $HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/"$TITLE"/

# Installing components
POL_Call POL_Install_vcrun6
POL_Call POL_Install_physx

# Cleanup
POL_Shortcut "UruLauncher.exe" "Minkata"
POL_SetupWindow_Close
exit

