#!/usr/bin/env playonlinux-bash
# Date: 2018-06-16 23:00 GMT
# Wine version used: 3.0
# Distribution used to test: macOS 10.14.6 "Mojave" & Lubuntu 17.10 64 (VirtualBox)
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
cd "$SHARDPATH/"
POL_Download "http://www.the-deep-island.de/shard/di-patcher.zip"
unzip -o di-patcher.zip
rm di-patcher.zip


# Enabling widescreen
echo -e "width=auto\r\nheight=auto\r\n" > urustarter.ini


# Cleanup
POL_System_TmpDelete
POL_Shortcut "Uru.exe" "$TITLE"
POL_SetupWindow_Close
exit
