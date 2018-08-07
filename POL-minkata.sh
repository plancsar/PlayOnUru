#!/usr/bin/env playonlinux-bash
# Date: 2018-01-30 19:50 GMT
# Wine version used: 3.0
# Distribution used to test: Lubuntu 17.10 64 (VirtualBox)
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
POL_Call POL_Install_physx


# If MO:ULa is already installed in $MOULAPATH, copy the datafiles from there
if [ -d $HOME/Library/PlayOnMac ]; then
    MOULAPATH="$HOME/Library/PlayOnMac/wineprefix/mystonline/drive_c/Program Files/Uru Live"
    SHARDPATH="$HOME/Library/PlayOnMac/wineprefix/$PREFIX/drive_c/Program Files/Minkata"
    RENAMPATH="$HOME/Library/PlayOnMac/wineprefix/$PREFIX/drive_c/Program Files/Uru Live"
elif [ -d $HOME/.PlayOnLinux ]; then
    MOULAPATH="$HOME/.PlayOnLinux/wineprefix/mystonline/drive_c/Program Files/Uru Live"
    SHARDPATH="$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program Files/Minkata"
    RENAMPATH="$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program Files/Uru Live"
fi

if [ "$(POL_Wine_PrefixExists 'mystonline')" = "True" ]; then
    mkdir "$SHARDPATH"
    POL_SetupWindow_wait "Copying data from the Myst Online prefix..." "$TITLE"
    cp -r "$MOULAPATH"/dat "$MOULAPATH"/sfx "$MOULAPATH"/avi "$SHARDPATH"/

# If MO:ULa is not installed, download and launch the installer
else
    POL_Download "http://account.mystonline.com/download/MOULInstaller.exe"
    POL_Wine MOULInstaller.exe
    POL_Wine_WaitExit "$TITLE"

    #Rename the Uru Live folder to "Minkata", to let the installer recognize it
    mv "$RENAMPATH" "$SHARDPATH"
fi


# Copy the game files from the Uru Live prefix and adding Minkata's Launcher
cd "$SHARDPATH"/
rm UruLauncher.exe
POL_Download "http://foundry.openuru.org/jenkins/job/CWE-ou-minkata-Compile/lastSuccessfulBuild/BuildType=External,Platform=Windows2k3Builder/artifact/MOULOpenSourceClientPlugin/Plasma20/MsDevProjects/Plasma/Apps/plUruLauncher/Release/UruLauncher.exe"

# Cleanup
POL_System_TmpDelete
POL_Shortcut "UruLauncher.exe" "Minkata"
POL_SetupWindow_Close
exit
