#!/usr/bin/env playonlinux-bash
# Date: 2018-01-31 23:00 GMT
# Wine version used: 3.0
# Distribution used to test: Lubuntu 17.10 64 (VirtualBox)
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Deep Island"
PREFIX="deepisland"


POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Guild of Writers" "https://forum.guildofwriters.org/viewforum.php?f=111" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"


# Installing components
POL_Call POL_Install_vcrun6
POL_Call POL_Install_physx


# Ask for the location of the GOG installer and launch it
POL_SetupWindow_browse "Please select the GOG installer." "$TITLE"
POL_Wine $APP_ANSWER
POL_Wine_WaitExit "$TITLE"

if [ -d $HOME/.PlayOnLinux ]; then
    SHARDPATH="$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/GOG Games/Myst Uru Complete Chronicles"
elif [ -d $HOME/Library/PlayOnMac ]; then
    SHARDPATH="$HOME/Library/PlayOnMac/wineprefix/$PREFIX/drive_c/GOG Games/Myst Uru Complete Chronicles"
fi

# Patch the game for use with Deep Island
cd "$SHARDPATH"/
POL_Download "http://www.the-deep-island.de/shard/di-patcher.zip"
unzip di-patcher.zip
rm di-patcher.zip


# Cleanup
POL_System_TmpDelete
POL_Shortcut "Uru.exe" "$TITLE"
POL_SetupWindow_Close
exit

