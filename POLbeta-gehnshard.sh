#!/usr/bin/env playonlinux-bash
# Date: 2017-05-20 14:00 GMT
# Wine version used: 1.9.24
# Distribution used to test: Ubuntu 16.10, 64 bit (VirtualBox)
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Gehn Shard"
PREFIX="gehnshard"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Guild of Writers" "https://www.guildofwriters.org/gehn/" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "1.9.24"
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Installing MO:ULa first, to get the datafiles
POL_Download "http://account.mystonline.com/download/MOULInstaller.exe"
POL_Wine "$POL_System_TmpDir/MOULInstaller.exe"
POL_Wine_WaitExit "$TITLE"

#Renaming the Uru Live folder to "Gehn Shard"
mv $HOME/.PlayOnLinux/wineprefix/gehnshard/drive_c/Program\ Files/Uru\ Live $HOME/.PlayOnLinux/wineprefix/gehnshard/drive_c/Program\ Files/Gehn\ Shard

# Installing vcrun2015 with Winetricks,
# since it's missing from POL's components
POL_Download "https://raw.githubusercontent.com/winetricks/winetricks/master/src/winetricks"
chmod +x winetricks
WINEPREFIX=$HOME/.PlayOnLinux/wineprefix/$PREFIX $POL_System_TmpDir/winetricks vcrun2015
POL_Call POL_Install_d3dx10

# Setting the virtualized system to Win 8
# Should be done now, as vcrun2015 will reset the system to Win XP
Set_OS "win8"

# Installing the shard
POL_Download "https://guildofwriters.org/cwe/gehn_shard.exe"
POL_Wine "$POL_System_TmpDir/gehn_shard.exe"
POL_Wine_WaitExit "$TITLE"

# Cleanup
POL_System_TmpDelete
POL_Shortcut "UruLauncher.exe" "$TITLE"
POL_SetupWindow_Close
exit
