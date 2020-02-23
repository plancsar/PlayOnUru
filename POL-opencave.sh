#!/usr/bin/env playonlinux-bash
# Date: 2020-02-23
# Wine version used: 3.0
# Distribution used to test: Lubuntu 18.04 LTS 64bit (VirtualBox)
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Open Cave"
PREFIX="toc_moul"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "$TITLE" "http://the-open-cave.net/en/" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Installing components
POL_Call POL_Install_vcrun2013

# If MO:ULa is already installed in $MOULAPATH, copy the datafiles from there
if [ -d $HOME/Library/PlayOnMac ]; then
    MOULAPATH="$HOME/Library/PlayOnMac/wineprefix/mystonline/drive_c/Program Files/Uru Live"
    SHARDPATH="$HOME/Library/PlayOnMac/wineprefix/$PREFIX/drive_c/Program Files/TOC-Moul"
    RENAMPATH="$HOME/Library/PlayOnMac/wineprefix/$PREFIX/drive_c/Program Files/Uru Live"
elif [ -d $HOME/.PlayOnLinux ]; then
    MOULAPATH="$HOME/.PlayOnLinux/wineprefix/mystonline/drive_c/Program Files/Uru Live"
    SHARDPATH="$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program Files/TOC-Moul"
    RENAMPATH="$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program Files/Uru Live"
fi

if [ "$(POL_Wine_PrefixExists 'mystonline')" = "True" ]; then
    mkdir "$SHARDPATH"
    POL_SetupWindow_wait "Copying data from the Myst Online prefix..." "$TITLE"
    cp -r "$MOULAPATH"/dat "$MOULAPATH"/sfx "$MOULAPATH"/avi "$SHARDPATH"/

# Install the game
POL_Download "http://other.the-open-cave.net/installer/TOC-Moul.exe"
POL_Wine TOC-Moul.exe
POL_Wine_WaitExit "$TITLE"

# Cleanup
POL_System_TmpDelete 
POL_Shortcut "UruLauncher.exe" "$TITLE"
POL_SetupWindow_Close
exit
