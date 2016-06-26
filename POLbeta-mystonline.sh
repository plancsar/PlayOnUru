#!/usr/bin/env playonlinux-bash
# Date : 2016-06-26 11:00
# Wine version used : 1.7.18
# Distribution used to test : Ubuntu 16.04 LTS 64 (VirtualBox)
# Author : Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Myst Online: Uru Live (again)"
PREFIX="mystonline"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Cyan, Inc." "http://mystonline.com" "Korovev" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "1.5.31"
Set_Desktop "On" "1024" "768"

# Download & Install the game.
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "http://account.mystonline.com/download/MOULInstaller.exe"

POL_Call POL_Install_vcrun6
POL_Call POL_Install_physx

POL_Wine "$POL_System_TmpDir/MOULInstaller.exe"

POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete
 
POL_Shortcut "UruLauncher.exe" "Uru Live"
POL_SetupWindow_Close
exit

