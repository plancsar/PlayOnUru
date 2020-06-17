#!/bin/bash
# Date: 2020-06-17
# Wine version used: 3.0
# Distribution used to test: macOS 10.14.6 "Mojave" & Lubuntu 18.04 LTS 64bit (VirtualBox)
# Author: Korovev
# Description: A basic script to install Uru CC-based shards on macOS or Linux.
#   It assumes a recent version of Wine (from WineHQ) and winetricks
#   are already installed.
#   The script requires the Uru Complete Chronicles app (macOS) or
#   the Windows GOG installer (Linux) to be in the same folder.

read -p "Do you prefer instructions in English or D'ni? [1 English, 5 D'ni] " lang
if [[ $lang == "5" ]]; then
    echo "Sorry! Not available. Continuing in English."
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    BASHFILE=".profile"
else
    BASHFILE=".bashrc"
fi

SCRIPTPATH=$(pwd)

while true; do
    shard="none"
    read -p 'Which shard do you wish to install? [1 Uru CC + Drizzle, 2 Deep Island, 3 TOC, 0 exit] ' shard
    case $shard in
        1)
            SHARDPREFIX="$HOME/uru-uruccdrizzle"
            SHARDFOLDER="$SHARDPREFIX/drive_c/Program Files"

            yn="n"
            if [ -d "$SHARDPREFIX" ]; then
                read -p 'Uru CC is already installed! Do you want to DELETE the prefix and reinstall? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                read -p 'Are you sure? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                rm -r "$SHARDPREFIX"
            fi

            WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun6 >> $HOME/uru-wine.log 2>&1

            cd "$SCRIPTPATH"
                   # Copy the game files from the 25th anniversary app if macOS
            if [[ "$OSTYPE" == "darwin"* ]]; then
                if [ ! -d "Uru Complete Chronicles.app" ]; then
                   echo 'Uru Complete Chronicles not found! Exiting.'
                   exit
                fi
                echo "Copying data from the Uru CC app..."
                cp -r "Uru Complete Chronicles.app/Contents/SharedSupport/uru_cc/support/uru/drive_c/URU-CC" "$SHARDFOLDER"
                cp -r "$HOME/Library/Application Support/Uru Complete Chronicles/Bottles/uru/drive_c/URU-CC/sav" "$SHARDFOLDER/URU-CC/"
                SHARDFOLDER="$SHARDFOLDER/URU-CC"

            else    # Use the GOG installer on Linux
                if [ ! -f "setup_uru_cc_2.0.0.5.exe" ]; then
                   echo 'Uru Complete Chronicles not found! Exiting.'
                   exit
                fi
                echo "Launching the installer (give it a few seconds)..."
                sleep 5
                WINEPREFIX="$SHARDPREFIX" wine start /unix "setup_uru_cc_2.0.0.5.exe" >> $HOME/uru-wine.log 2>&1
                echo "Advance the installer with the mouse, the keyboard may be intercepted by the script."
                echo "When the installation and updating is done, press any key to continue."
                read -n 1 -s -r
                cd "$SHARDPREFIX/drive_c/GOG Games/"
                mv "Myst Uru Complete Chronicles" "Uru CC"
                SHARDFOLDER="$SHARDPREFIX/drive_c/GOG Games/Uru CC"
            fi
            
            echo "Patching the client..."
            cd "$SHARDFOLDER/"
            curl -L -O "https://account.mystonline.com/download/UruCCBeta.zip"
            unzip -o UruCCBeta.zip && rm UruCCBeta.zip
            mv UruCCBeta/Readme.txt  UruCCBeta/Readme114.txt
            cp UruCCBeta/* .
            rm -r UruCCBeta
            
            curl -L -o drizzle32-07-03-20.zip "https://www.dropbox.com/s/lomvhkofnpwxmyj/drizzle32-07-03-20.zip?dl=1"
            unzip -o drizzle32-07-03-20.zip && rm drizzle32-07-03-20.zip
            cp Uru/dat/*     dat/
            cp Uru/python/*  Python/
            cp Uru/sdl/*     SDL/
            rm -r Uru
            
            mkdir $HOME/bin
            chmod 755 Drizzle32.jar
            mv Drizzle32.jar $HOME/bin/

            read -p "Do you wish to add the 'uruccdrizzle' alias to $BASHFILE ? [y/n] " yn
            if [[ $yn == "y" || $yn == "Y" ]]; then
                aliaspath="alias uruccdrizzle='WINEPREFIX=\"$SHARDPREFIX\" wine start /unix \"$SHARDFOLDER/UruSetup.exe\"'"
                echo $aliaspath >> $HOME/$BASHFILE
            fi
            ;;
        2)
            SHARDPREFIX="$HOME/uru-deepisland"
            SHARDFOLDER="$SHARDPREFIX/drive_c/Program Files"

            yn="n"
            if [ -d "$SHARDPREFIX" ]; then
                read -p 'Deep Island is already installed! Do you want to DELETE the prefix and reinstall? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                read -p 'Are you sure? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                rm -r "$SHARDPREFIX"
            fi

            WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun6 >> $HOME/uru-wine.log 2>&1

            cd "$SCRIPTPATH"
                   # Copy the game files from the 25th anniversary app if macOS
            if [[ "$OSTYPE" == "darwin"* ]]; then

                if [ ! -d "Uru Complete Chronicles.app" ]; then
                   echo 'Uru Complete Chronicles not found! Exiting.'
                   exit
                fi
                echo "Copying data from the Uru CC app..."
                cp -r "Uru Complete Chronicles.app/Contents/SharedSupport/uru_cc/support/uru/drive_c/URU-CC" "$SHARDFOLDER"
                SHARDFOLDER="$SHARDFOLDER/URU-CC"

            else    # Use the GOG installer on Linux
                if [ ! -f "setup_uru_cc_2.0.0.5.exe" ]; then
                   echo 'Uru Complete Chronicles not found! Exiting.'
                   exit
                fi
                echo "Launching the installer (give it a few seconds)..."
                sleep 5
                WINEPREFIX="$SHARDPREFIX" wine start /unix "setup_uru_cc_2.0.0.5.exe" >> $HOME/uru-wine.log 2>&1
                echo "Advance the installer with the mouse, the keyboard may be intercepted by the script."
                echo "When the installation and updating is done, press any key to continue."
                read -n 1 -s -r
                cd "$SHARDPREFIX/drive_c/GOG Games/"
                mv "Myst Uru Complete Chronicles" "Uru CC"
                SHARDFOLDER="$SHARDPREFIX/drive_c/GOG Games/Uru CC"
            fi
            
            echo "Patching the client..."
            cd "$SHARDFOLDER"
            curl -L -O "http://www.the-deep-island.de/shard/di-patcher.zip"
            unzip -o di-patcher.zip && rm di-patcher.zip
            echo -e "width=auto\r\nheight=auto\r\n" > urustarter.ini

            read -p "Do you wish to add the 'deepisland' alias to $BASHFILE ? [y/n] " yn
            if [[ $yn == "y" || $yn == "Y" ]]; then
                aliaspath="alias deepisland='WINEPREFIX=\"$SHARDPREFIX\" wine start /unix \"$SHARDFOLDER/Uru.exe\"'"
                echo $aliaspath >> $HOME/$BASHFILE
            fi
            ;;
        3)
            SHARDPREFIX="$HOME/uru-opencave-pots"
            SHARDFOLDER="$SHARDPREFIX/drive_c/Program Files"

            yn="n"
            if [ -d "$SHARDPREFIX" ]; then
                read -p 'The Open Cave (PotS) is already installed! Do you want to DELETE the prefix and reinstall? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                read -p 'Are you sure? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                rm -r "$SHARDPREFIX"
            fi

            WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun6 >> $HOME/uru-wine.log 2>&1

            cd "$SCRIPTPATH"
                   # Copy the game files from the 25th anniversary app if macOS
            if [[ "$OSTYPE" == "darwin"* ]]; then

                if [ ! -d "Uru Complete Chronicles.app" ]; then
                   echo 'Uru Complete Chronicles not found! Exiting.'
                   exit
                fi
                echo "Copying data from the Uru CC app..."
                cp -r "Uru Complete Chronicles.app/Contents/SharedSupport/uru_cc/support/uru/drive_c/URU-CC" "$SHARDFOLDER"
                SHARDFOLDER="$SHARDFOLDER/URU-CC"

            else    # Use the GOG installer on Linux
                if [ ! -f "setup_uru_cc_2.0.0.5.exe" ]; then
                   echo 'Uru Complete Chronicles not found! Exiting.'
                   exit
                fi
                echo "Launching the installer (give it a few seconds)..."
                sleep 5
                WINEPREFIX="$SHARDPREFIX" wine start /unix "setup_uru_cc_2.0.0.5.exe" >> $HOME/uru-wine.log 2>&1
                echo "Advance the installer with the mouse, the keyboard may be intercepted by the script."
                echo "When the installation and updating is done, press any key to continue."
                read -n 1 -s -r
                cd "$SHARDPREFIX/drive_c/GOG Games/"
                mv "Myst Uru Complete Chronicles" "Uru CC"
                SHARDFOLDER="$SHARDPREFIX/drive_c/GOG Games/Uru CC"
            fi
            
            echo "Patching the client..."
	    cd "$SHARDFOLDER"
            curl -L -O "http://other.the-open-cave.net/installer/tocpatch.v3.zip"
            unzip -o tocpatch.v3.zip
            rm tocpatch.v3.zip
            WINEPREFIX="$SHARDPREFIX" wine start /unix "tocpatch.v3.exe" >> $HOME/uru-wine.log 2>&1
            echo "Advance the patcher with the mouse, the keyboard may be intercepted by the script."
            echo "When the installation and updating is done, press any key to continue."
            read -n 1 -s -r

            read -p "Do you wish to add the 'opencavepots' alias to $BASHFILE ? [y/n] " yn
            if [[ $yn == "y" || $yn == "Y" ]]; then
                aliaspath="alias opencavepots='WINEPREFIX=\"$SHARDPREFIX\" wine start /unix \"$SHARDFOLDER/UruSetup.exe\"'"
                echo $aliaspath >> $HOME/$BASHFILE
            fi
            ;;
        0)
            exit ;;
        *)
            yn="n"
            read -p 'Do you want to exit? [y/n] ' shard
            if [[ $shard == "y" || $shard == "Y" ]]; then
                exit
            fi
            ;;
    esac

    yn="n"
    read -p 'Do you want to install another shard? [y/n] ' yn
    if [[ $yn == "y" || $yn == "Y" ]]; then
        continue
    else
        echo "If the shards work correctly, you can delete the uru-installers folder."
        if [[ $lang == "5" ]]; then
            echo "Kenem k'teshij yeret!"
        else
            echo "Have fun!"
        fi
        exit
    fi
done
