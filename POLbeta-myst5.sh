#!/usr/bin/env playonlinux-bash
# Date: 2021-01-15
# Wine version used: 5.7
# Distribution used to test: macOS 10.14.5 "Mojave" & Lubuntu 20.04 LTS 64bit
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Myst V: End of Ages"
PREFIX="myst5"


POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Cyan, Inc." "https://cyan.com" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "5.7"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"


# Installing components
#POL_Call POL_Install_vcrun6


#  Copy the game files from the 25th anniversary app if macOS
#  Use the GOG installer on Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    SHARDPATH="$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/"
    POL_SetupWindow_browse "Please select the 25th Anniversary Myst V app." "$TITLE"
    POL_SetupWindow_wait "Copying data from the Myst V app..." "$TITLE"
    cp -r "$APP_ANSWER/Contents/SharedSupport/myst_v/support/myst_v/drive_c/Myst V" "$SHARDPATH"
#    cp -r "$HOME/Library/Application Support/Uru Complete Chronicles/Bottles/uru/drive_c/URU-CC/sav" "$SHARDPATH/URU-CC/"
    SHARDPATH="$SHARDPATH/Myst V"
else
    POL_SetupWindow_browse "Please select the Windows GOG installer." "$TITLE"
    POL_Wine $APP_ANSWER
    POL_Wine_WaitExit "$TITLE"
    cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/GOG Games/"
    mv "Myst V End Of Ages" "MystV"
    SHARDPATH="$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/GOG Games/MystV"
fi

cd $SHARDPATH
cp eoa.exe MystV.exe

# Cleanup
POL_System_TmpDelete
POL_Shortcut "eoa.exe" "$TITLE"
POL_SetupWindow_Close
exit
