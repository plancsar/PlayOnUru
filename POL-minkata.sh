#!/usr/bin/env playonlinux-bash
# Date: 2020-06-03
# Wine version used: 3.0
# Distribution used to test: macOS 10.14.6 "Mojave" & Lubuntu 18.04 LTS 64bit (VirtualBox)
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Minkata Shard"
PREFIX="minkata"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "OpenUru.org" "http://openuru.org/" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0"
#Set_Desktop "On" "1024" "768"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Installing components
POL_Call POL_Install_vcrun6
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
POL_Download "http://foundry.openuru.org/jenkins/job/CWE-ou-minkata-Compile/lastSuccessfulBuild/BuildType=External,Platform=Windows2k3Builder/artifact/MOULOpenSourceClientPlugin/Plasma20/MsDevProjects/Plasma/Apps/plUruLauncher/Release/UruLauncher.exe"

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
