#!/usr/bin/env playonlinux-bash
# Date: 2020-08-19
# Wine version used: 3.0
# Distribution used to test: macOS 10.14.6 "Mojave" & Lubuntu 18.04 LTS 64bit (VirtualBox)
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
POL_Call POL_Install_d3dx10
POL_Call POL_Install_vcrun2012
POL_Call POL_Install_crypt32
POL_Wine_WaitExit "$TITLE"

# Download & Install the game
curl -L -O "http://account.mystonline.com/download/MOULInstaller.exe"
POL_Wine MOULInstaller.exe
POL_Wine_WaitExit "$TITLE"

# Cleanup
POL_System_TmpDelete
POL_Shortcut "UruLauncher.exe" "Uru Live"
POL_SetupWindow_Close
exit
