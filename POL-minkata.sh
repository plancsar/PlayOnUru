#!/usr/bin/env playonlinux-bash
# Date: 2021-01-13
# Wine version used: 5.7
# Distribution used to test: macOS 10.14.5 "Mojave" & Lubuntu 20.04 LTS 64bit
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Minkata Shard"
PREFIX="minkata"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "OpenUru.org" "http://openuru.org/" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "5.7"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Installing components
POL_Call POL_Install_winhttp
#POL_Call POL_Install_d3dx10
#POL_Call POL_Install_vcrun2012
#POL_Call POL_Install_crypt32
POL_Wine_WaitExit "$TITLE"

# If MO:ULa is already installed in $MOULAPATH, copy the datafiles from there
MOULAPATH="$POL_USER_ROOT/wineprefix/mystonline/drive_c/Myst Online Uru Live(again)"
WPATH="$POL_USER_ROOT/wineprefix/$PREFIX"
SHARDPATH="$WPATH/drive_c/Program Files/Minkata"
RENAMPATH="$WPATH/drive_c/Program Files/Uru Live"

if [ "$(POL_Wine_PrefixExists 'mystonline')" = "True" ]; then
    mkdir "$SHARDPATH"
    POL_SetupWindow_wait "Copying data from the Myst Online prefix..." "$TITLE"
    cp -r "$MOULAPATH"/dat "$MOULAPATH"/sfx "$MOULAPATH"/avi "$SHARDPATH"/

# If MO:ULa is not installed, download and launch the installer
else
    POL_Download "http://account.mystonline.com/download/MOULInstaller.exe"
    POL_Wine MOULInstaller.exe
    POL_Wine_WaitExit "$TITLE"

    #Rename the Uru Live folder to "Minkata"
    mv "$RENAMPATH" "$SHARDPATH"
fi

# Copy the game files from the Uru Live prefix and adding Minkata's Launcher
cd "$SHARDPATH"/
rm UruLauncher.exe
POL_Download "https://foundry.openuru.org/jenkins/job/CWE-ou-minkata-Compile-Git/lastSuccessfulBuild/artifact/Plasma/Apps/plUruLauncher/Release/UruLauncher.exe"

# Adding a Minkata Alpha folder
cd ..
cp -r Minkata Minkata\ Alpha
cd Minkata-alpha

# Cleanup
POL_System_TmpDelete
POL_Shortcut "Program Files/Minkata/UruLauncher.exe" "Minkata"
POL_Shortcut "Program Files/Minkata Alpha/UruLauncher.exe" "Minkata Alpha" "" "/GateKeeperSrv=70.91.173.88:14717 /FileSrv=70.91.173.88:14717 /AuthSrv=70.91.173.88:14717"
POL_SetupWindow_Close
exit
