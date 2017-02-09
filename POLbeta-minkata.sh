#!/usr/bin/env playonlinux-bash
# Date : 2017-02-09 21:35 GMT
# Wine version used : 1.7.18
# Distribution used to test : Ubuntu 16.04 LTS 64 (VirtualBox)
# Author : Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Minkata Shard"
PREFIX="minkatashard"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "OpenUru.org" "http://openuru.org/" "Korovev" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "1.7.18"
#Set_Desktop "On" "1024" "768"

# Copy the game files from the Uru Live prefix.

cd
wget https://github.com/plancsar/PlayOnUru/blob/master/MinkataLauncher.zip
unzip MinkataLauncher.zip
mkdir .PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/"$TITLE"
mv UruLauncher.exe .PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/"$TITLE"/
cp -r .PlayOnLinux/wineprefix/mystonline/drive_c/Program\ Files/Uru\ Live/dat .PlayOnLinux/wineprefix/mystonline/drive_c/Program\ Files/Uru\ Live/sfx .PlayOnLinux/wineprefix/mystonline/drive_c/Program\ Files/Uru\ Live/avi .PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/"$TITLE"/
rm MinkataLauncher.zip
POL_Call POL_Install_vcrun6
POL_Call POL_Install_physx
 
POL_Shortcut "UruLauncher.exe" "Minkata"
POL_SetupWindow_Close
exit

