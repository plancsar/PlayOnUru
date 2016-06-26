#!/usr/bin/env playonlinux-bash
# Date : 2016-06-25 22:00
# Wine version used : 1.7.18
# Distribution used to test : Ubuntu 16.04 LTS 64 (VirtualBox)
# Author : Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Open Cave"
PREFIX="toc_moul"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "$TITLE" "http://the-open-cave.net/en/" "Korovev" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "1.7.18"

# Download & Install the game.
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "http://other.the-open-cave.net/installer/TOC-Moul.exe"

POL_Call POL_Install_vcrun2013
POL_Call POL_Install_physx

POL_Wine "$POL_System_TmpDir/TOC-Moul.exe"

POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete
 
POL_Shortcut "UruLauncher.exe" "The Open Cave"
POL_SetupWindow_Close
exit

