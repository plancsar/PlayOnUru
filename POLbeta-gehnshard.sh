#!/usr/bin/env playonlinux-bash
# Date : 2016-06-25 23:55
# Wine version used : 1.9.5
# Distribution used to test : Ubuntu 16.04 LTS 64 (VirtualBox)
# Author : Korovev

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Gehn Shard"
PREFIX="gehnshard"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Guild of Writers" "https://www.guildofwriters.org/gehn/" "Korovev" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "1.9.5"
#Set_OS "win8"

# Download & Install the game.
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "https://guildofwriters.org/cwe/gehn_shard.exe"

POL_Call POL_Install_vcrun2013
POL_Call POL_Install_physx

POL_Wine "$POL_System_TmpDir/gehn_shard.exe"

POL_Wine_WaitExit "$TITLE"

wget https://www.dropbox.com/s/trsjl0s2w1l1fbs/GehnShardDLL.zip
unzip GehnShardDLL.zip
cd GehnShardDLL
mv -f *.dll ~/.PlayOnLinux/wineprefix/$PREFIX/drive_c/windows/system32/
POL_Wine_OverrideDLL "native" "msvcp140"
POL_Wine_OverrideDLL "native" "vcruntime140"
POL_Wine_OverrideDLL "native" "ucrtbase"
POL_Wine_OverrideDLL "native" "api-ms-win-crt-locale-l1-1-0"
POL_Wine_OverrideDLL "native" "api-ms-win-crt-runtime-l1-1-0"
POL_Wine_OverrideDLL "native" "api-ms-win-crt-stdio-l1-1-0"
POL_Wine_OverrideDLL "native" "api-ms-win-crt-heap-l1-1-0"
POL_Wine_OverrideDLL "native" "api-ms-win-crt-conio-l1-1-0"

POL_System_TmpDelete
 
POL_Shortcut "UruLauncher.exe" "Gehn Shard"
POL_SetupWindow_Close
exit

