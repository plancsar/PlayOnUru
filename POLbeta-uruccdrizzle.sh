#!/usr/bin/env playonlinux-bash
# Date: 2021-01-13
# Wine version used: 5.7
# Distribution used to test: macOS 10.14.5 "Mojave" & Lubuntu 20.04 LTS 64bit
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Uru CC Drizzle"
PREFIX="uruccdrizzle"


POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Guild of Writers" "https://forum.guildofwriters.org/viewforum.php?f=111" "Korovev" "$PREFIX"

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
    POL_SetupWindow_browse "Please select the 25th Anniversary Uru Complete Chronicles app." "$TITLE"
    POL_SetupWindow_wait "Copying data from the Uru CC app..." "$TITLE"
    cp -r "$APP_ANSWER/Contents/SharedSupport/uru_cc/support/uru/drive_c/URU-CC" "$SHARDPATH"
    cp -r "$HOME/Library/Application Support/Uru Complete Chronicles/Bottles/uru/drive_c/URU-CC/sav" "$SHARDPATH/URU-CC/"
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
POL_Download "https://account.mystonline.com/download/UruCCBeta.zip"
unzip -o UruCCBeta.zip && rm UruCCBeta.zip
mv UruCCBeta/Readme.txt  UruCCBeta/Readme114.txt
cp UruCCBeta/* .
rm -r UruCCBeta

POL_Download "https://www.dropbox.com/s/lomvhkofnpwxmyj/drizzle32-07-03-20.zip?dl=1"
mv "drizzle32-07-03-20.zip?dl=1" "drizzle32-07-03-20.zip"
unzip -o drizzle32-07-03-20.zip && rm drizzle32-07-03-20.zip
cp Uru/dat/*     dat/
cp Uru/python/*  Python/
cp Uru/sdl/*     SDL/
rm -r Uru

mkdir $HOME/bin
chmod 755 Drizzle32.jar
mv Drizzle32.jar $HOME/bin/


# Cleanup
POL_System_TmpDelete
POL_Shortcut "UruSetup.exe" "$TITLE"
POL_SetupWindow_Close
exit
