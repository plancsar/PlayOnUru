#!/usr/bin/env playonlinux-bash
# Date: 2020-02-23
# Wine version used: 3.0
# Distribution used to test: Lubuntu 18.04 LTS 64bit (VirtualBox)
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Myst Online: Uru Live (again)"
PREFIX="mystonline"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Cyan, Inc." "http://mystonline.com" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0"
#Set_Desktop "On" "1024" "768"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Installing components
POL_Call POL_Install_vcrun6
POL_Download "https://raw.githubusercontent.com/plancsar/PlayOnUru/master/PhysX_Setup.exe"
POL_Wine PhysX_Setup.exe
POL_Wine_WaitExit "$TITLE"

# Download & Install the game
POL_Download "http://account.mystonline.com/download/MOULInstaller.exe"
POL_Wine MOULInstaller.exe
POL_Wine_WaitExit "$TITLE"

# Cleanup
POL_System_TmpDelete
POL_Shortcut "UruLauncher.exe" "Uru Live"
POL_SetupWindow_Close
exit
