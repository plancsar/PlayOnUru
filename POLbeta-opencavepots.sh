#!/usr/bin/env playonlinux-bash
# Date: 2018-06-16 23:00 GMT
# Wine version used: 3.0
# Distribution used to test: macOS 10.14.6 "Mojave" & Lubuntu 18.04 LTS 64bit (VirtualBox)
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Open Cave PotS"
PREFIX="toc_pots"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "$TITLE" "http://the-open-cave.net/en/" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"


# Installing components
POL_Call POL_Install_vcrun6


#  Copy the game files from the 25th anniversary app if macOS
#  Use the GOG installer on Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    SHARDPATH="$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/"
    POL_SetupWindow_browse "Please select the 25th Anniversary Uru Complete Chronicles app." "$TITLE"
    POL_SetupWindow_wait "Copying data from the Uru CC app..." "$TITLE"
    cp -r "$APP_ANSWER/Contents/SharedSupport/uru_cc/support/uru/drive_c/URU-CC" "$SHARDPATH"
    SHARDPATH="$SHARDPATH/URU-CC"
else
    POL_SetupWindow_browse "Please select the Windows GOG installer." "$TITLE"
    POL_Wine $APP_ANSWER
    POL_Wine_WaitExit "$TITLE"
    cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/GOG Games/"
    mv "Myst Uru Complete Chronicles" "Uru CC"
    SHARDPATH="$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/GOG Games/Uru CC"
fi


# Patching the game
cd "$SHARDPATH"/
curl -L -O "http://other.the-open-cave.net/installer/tocpatch.v3.zip"
unzip -o tocpatch.v3.zip
rm tocpatch.v3.zip
POL_Wine tocpatch.v3.exe


# Cleanup
POL_System_TmpDelete
POL_Shortcut "UruSetup.exe" "$TITLE"
POL_SetupWindow_Close
exit
