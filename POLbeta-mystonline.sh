#!/usr/bin/env playonlinux-bash
# Date: 2017-02-12 13:35 GMT
# Wine version used: 1.7.18
# Distribution used to test: Ubuntu 16.04 LTS 64 (VirtualBox)
# Author: Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Myst Online: Uru Live (again)"
PREFIX="mystonline"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Cyan, Inc." "http://mystonline.com" "Korovev" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "1.7.18"
#Set_Desktop "On" "1024" "768"

#POL_System_TmpCreate "$PREFIX"
#cd "$POL_System_TmpDir"

# Installing components
POL_Call POL_Install_vcrun6
POL_Call POL_Install_physx

# Download & Install the game
cd $HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/
POL_Download "https://github.com/plancsar/PlayOnUru/raw/master/urulive_setup.zip"
unzip urulive_setup.zip
rm urulive_setup.zip

# Cleanup
#POL_System_TmpDelete
POL_Shortcut "UruLauncher.exe" "Uru Live"
POL_SetupWindow_Close
exit

