#!/usr/bin/env playonlinux-bash
# Date: 2017-02-12 13:25 GMT
# Wine version used: 1.9.24
# Distribution used to test: Ubuntu 16.04 LTS 64 (VirtualBox)
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
#Set_OS "win8"
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Installing physx
#POL_Call POL_Install_vcrun2013 -- replaced by vcrun2015
POL_Call POL_Install_physx

# Installing vcrun2015 and d3dx10 with Winetricks,
# since they're missing from POL's one
POL_Download "https://raw.githubusercontent.com/winetricks/winetricks/master/src/winetricks"
chmod +x winetricks
WINEPREFIX=$HOME/.PlayOnLinux/wineprefix/$PREFIX $POL_System_TmpDir/winetricks vcrun2015 d3dx10

# Adding DLLs missing from Winetricks
#POL_Download "https://github.com/plancsar/PlayOnUru/raw/master/GehnShardDLL.zip"
#unzip GehnShardDLL.zip
#mv -f GehnShardDLL/*.dll $HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/windows/system32/
#POL_Wine_OverrideDLL "native" "msvcp140"
#POL_Wine_OverrideDLL "native" "vcruntime140"
#POL_Wine_OverrideDLL "native" "ucrtbase"
#POL_Wine_OverrideDLL "native" "api-ms-win-crt-locale-l1-1-0"
#POL_Wine_OverrideDLL "native" "api-ms-win-crt-runtime-l1-1-0"
#POL_Wine_OverrideDLL "native" "api-ms-win-crt-stdio-l1-1-0"
#POL_Wine_OverrideDLL "native" "api-ms-win-crt-heap-l1-1-0"
#POL_Wine_OverrideDLL "native" "api-ms-win-crt-conio-l1-1-0"

# Coping the game files from the Uru Live prefix, if present
mkdir $HOME/.PlayOnLinux/wineprefix/$PREFIX/test
mkdir $HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/"$TITLE"
cp -r $HOME/.PlayOnLinux/wineprefix/mystonline/drive_c/Program\ Files/Uru\ Live/dat $HOME/.PlayOnLinux/wineprefix/mystonline/drive_c/Program\ Files/Uru\ Live/sfx $HOME/.PlayOnLinux/wineprefix/mystonline/drive_c/Program\ Files/Uru\ Live/avi $HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/"$TITLE"/

# Installing the shard
POL_Download "https://guildofwriters.org/cwe/gehn_shard.exe"
POL_Wine "$POL_System_TmpDir/gehn_shard.exe"
POL_Wine_WaitExit "$TITLE"

# Cleanup
POL_System_TmpDelete
POL_Shortcut "UruLauncher.exe" "$TITLE"
POL_SetupWindow_Close
exit

