#!/usr/bin/env playonlinux-bash
# Date: 2020-02-23
# Wine version used: 3.0
# Distribution used to test: Lubuntu 18.04 LTS 64bit (VirtualBox)
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Gehn Shard"
PREFIX="gehnshard"


POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Guild of Writers" "https://www.guildofwriters.org/gehn/" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Installing components
POL_Call POL_Install_d3dx10
# POL_Call POL_Install_vcrun2015
#POL_Call POL_Install_crypt32

# If MO:ULa is already installed in $MOULAPATH, copy the datafiles from there
if [ -d $HOME/Library/PlayOnMac ]; then
    MOULAPATH="$HOME/Library/PlayOnMac/wineprefix/mystonline/drive_c/Program Files/Uru Live"
    SHARDPATH="$HOME/Library/PlayOnMac/wineprefix/$PREFIX/drive_c/Program Files/Gehn Shard"
    RENAMPATH="$HOME/Library/PlayOnMac/wineprefix/$PREFIX/drive_c/Program Files/Uru Live"
    WPATH="$HOME/Library/PlayOnMac/wineprefix/$PREFIX"
elif [ -d $HOME/.PlayOnLinux ]; then
    MOULAPATH="$HOME/.PlayOnLinux/wineprefix/mystonline/drive_c/Program Files/Uru Live"
    SHARDPATH="$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program Files/Gehn Shard"
    RENAMPATH="$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program Files/Uru Live"
    WPATH="$HOME/.PlayOnLinux/wineprefix/$PREFIX"
fi

# Installing vcrun2015 with Winetricks, since it's missing from POL's components
POL_Download "https://raw.githubusercontent.com/winetricks/winetricks/master/src/winetricks"
chmod +x winetricks
WINEPREFIX="$WPATH" winetricks vcrun2015

# Setting the virtualized system to Win 8
# Should be done now, as vcrun2015 will reset the system to Win XP
# Set_OS "win8"

if [ "$(POL_Wine_PrefixExists 'mystonline')" = "True" ]; then
    mkdir "$SHARDPATH"
    POL_SetupWindow_wait "Copying data from the Myst Online prefix..." "$TITLE"
    cp -r "$MOULAPATH"/dat "$MOULAPATH"/sfx "$MOULAPATH"/avi "$SHARDPATH"/

# Installing the shard
POL_Download "https://guildofwriters.org/cwe/gehn_shard.exe"
POL_Wine gehn_shard.exe
POL_Wine_WaitExit "$TITLE"

# Cleanup
POL_System_TmpDelete
POL_Shortcut "UruLauncher.exe" "$TITLE"
POL_SetupWindow_Close
exit
