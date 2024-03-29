#!/usr/bin/env playonlinux-bash
# Date: 2021-04-02
# Wine version used: 5.7
# Distribution used to test: macOS 10.14.5 "Mojave" & Lubuntu 20.04 LTS 64bit
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Gehn Shard"
PREFIX="gehnshard64"

MOULAPATH="$POL_USER_ROOT/wineprefix/mystonline/drive_c/Myst Online Uru Live(again)"
WPATH="$POL_USER_ROOT/wineprefix/$PREFIX"
SHARDPATH="$WPATH/drive_c/Program Files/Gehn Shard"
RENAMPATH="$WPATH/drive_c/Program Files/Uru Live"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Guild of Writers" "https://www.guildofwriters.org/gehn/" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "5.7"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Installing components
#POL_Call POL_Install_d3dx10
#POL_Call POL_Install_vcrun2015
#POL_Call POL_Install_crypt32

# Installing vcrun2015 with Winetricks, since it's missing from POL's components
#POL_Download "https://raw.githubusercontent.com/winetricks/winetricks/master/src/winetricks"
#chmod +x winetricks
#WINEPREFIX="$WPATH" winetricks vcrun2015

# Setting the virtualized system to Win 8
# Should be done now, as vcrun2015 will reset the system to Win XP
# Set_OS "win8"

# If MO:ULa is already installed in $MOULAPATH, copy the datafiles from there
if [ "$(POL_Wine_PrefixExists 'mystonline')" = "True" ]; then
    mkdir -p "$SHARDPATH"
    POL_SetupWindow_wait "Copying data from the Myst Online prefix..." "$TITLE"
    cp -r "$MOULAPATH"/dat "$MOULAPATH"/sfx "$MOULAPATH"/avi "$SHARDPATH"/
fi

# Installing the shard
curl -k -L -O "https://guildofwriters.org/cwe/gehn_shard.exe"
POL_Wine gehn_shard.exe
POL_Wine_WaitExit "$TITLE"

# Cleanup
POL_System_TmpDelete
POL_Shortcut "UruLauncher.exe" "$TITLE"
POL_Shortcut "UruLauncher.exe" "$TITLE repair" "" "/ServerIni=repair.ini /Repair"
POL_SetupWindow_Close
exit
