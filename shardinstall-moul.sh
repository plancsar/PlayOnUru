#!/bin/bash
# Date: 2020-06-03
# Wine version used: 3.0
# Distribution used to test: macOS 10.14.6 "Mojave" & Lubuntu 18.04 LTS 64bit (VirtualBox)
# Author: Korovev
# Description: A basic script to install MOULa and shards on macOS or Linux.
#   It assumes a recent version of Wine (from WineHQ) and winetricks
#   are already installed.

read -p "Do you prefer instructions in English or D'ni? [1 English, 5 D'ni] " lang
if [[ $lang == "5" ]]; then
    echo "Sorry! Not available. Continuing in English."
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    BASHFILE=".profile"
else
    BASHFILE=".bashrc"
fi

while true; do
    shard="none"
    read -p 'Which shard do you wish to install? [1 MOUL, 2 Gehn, 3 TOC, 4 Minkata, 5 exit] ' shard
    case $shard in
        1)
            SHARDPREFIX="$HOME/uru-live"
            SHARDFOLDER="$SHARDPREFIX/drive_c/Program Files"

            yn="n"
            if [ -d "$SHARDPREFIX" ]; then
                read -p 'Myst Online: Uru Live is already installed! Do you want to DELETE the prefix and reinstall? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                read -p 'Are you sure? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                rm -r "$SHARDPREFIX"
            fi

            INSTALLDIR="$HOME/uru-installers"
            mkdir -p "$INSTALLDIR" && cd "$INSTALLDIR"

            echo "Installing Myst Online: Uru Live..."
            if [ ! -f "MOULInstaller.exe" ]; then
                echo "Downloading the installer..."
                curl -L -O "http://account.mystonline.com/download/MOULInstaller.exe"
                chmod 755 MOULInstaller.exe
            fi

            WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun6 >> $HOME/uru-wine.log 2>&1

            echo "Launching the installer (give it a few seconds)..."
            sleep 5

            WINEPREFIX="$SHARDPREFIX" wine start /unix "$INSTALLDIR/MOULInstaller.exe" >> $HOME/uru-wine.log 2>&1
            echo "Advance the installer with the mouse, the keyboard may be intercepted by the script."
            echo "When the installation and updating is done, press any key to continue."
            read -n 1 -s -r

            read -p "Do you wish to add the 'urulive' alias to $BASHFILE ? [y/n] " yn
            if [[ $yn == "y" || $yn == "Y" ]]; then
                echo "alias urulive=\"WINEPREFIX=$SHARDPREFIX wine start /unix $SHARDPREFIX/drive_c/Program\ Files/Uru\ Live/UruLauncher.exe\"" >> $HOME/$BASHFILE
            fi
            ;;
        2)
            SHARDPREFIX="$HOME/uru-gehn"
            SHARDFOLDER="$SHARDPREFIX/drive_c/Program Files"

            yn="n"
            if [ -d "$SHARDPREFIX" ]; then
                read -p 'The Gehn shard is already installed! Do you want to DELETE the prefix and reinstall? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                read -p 'Are you sure? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                rm -r "$SHARDPREFIX"
            fi

            INSTALLDIR="$HOME/uru-installers"
            mkdir -p "$INSTALLDIR" && cd "$INSTALLDIR"

            echo "Installing the Gehn shard..."
            echo "Downloading the installer..."
            curl -L -O "https://guildofwriters.org/cwe/gehn_shard.exe"
            chmod 755 gehn_shard.exe

            WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun2015 d3dx10 >> $HOME/uru-wine.log 2>&1

            if [ -d "$HOME/uru-live/drive_c/Program Files/Uru Live" ]; then
                echo "Copying MOUL files..."
                cp -r "$HOME/uru-live/drive_c/Program Files/Uru Live" "$SHARDFOLDER/"
                mv "$SHARDFOLDER/Uru Live" "$SHARDFOLDER/Gehn shard"
            fi

            echo "Launching the installer..."
            WINEPREFIX="$SHARDPREFIX" wine start /unix "$INSTALLDIR/gehn_shard.exe" >> $HOME/uru-wine.log 2>&1
            echo "Advance the installer with the mouse, the keyboard may be intercepted by the script."
            echo "When the installation and updating is done, press any key to continue."
            read -n 1 -s -r

            read -p "Do you wish to add the 'gehnshard' and 'gehnshard-repair' aliases to $BASHFILE ? [y/n] " yn
            if [[ $yn == "y" || $yn == "Y" ]]; then
                echo "alias gehnshard=\"WINEPREFIX=$SHARDPREFIX wine start /unix $SHARDPREFIX/drive_c/Program\ Files/Gehn\ Shard/UruLauncher.exe\"" >> $HOME/$BASHFILE
                echo "alias gehnshard-repair=\"WINEPREFIX=$SHARDPREFIX wine start /unix $SHARDPREFIX/drive_c/Program\ Files/Gehn\ Shard/UruLauncher.exe /ServerIni=repair.ini /Repair\"" >> $HOME/$BASHFILE
            fi
            ;;
        3)
            SHARDPREFIX="$HOME/uru-toc"
            SHARDFOLDER="$SHARDPREFIX/drive_c/Program Files"

            yn="n"
            if [ -d "$SHARDPREFIX" ]; then
                read -p 'The Open Cave is already installed! Do you want to DELETE the prefix and reinstall? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                read -p 'Are you sure? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                rm -r "$SHARDPREFIX"
            fi

            INSTALLDIR="$HOME/uru-installers"
            mkdir -p "$INSTALLDIR" && cd "$INSTALLDIR"

            echo "Installing the Open Cave shard..."
            echo "Downloading the installer..."
            curl -L -O "http://other.the-open-cave.net/installer/TOC-Moul.exe"
            chmod 755 TOC-Moul.exe

            WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun2013 d3dx10 >> $HOME/uru-wine.log 2>&1

            if [ -d "$HOME/uru-live/drive_c/Program Files/Uru Live" ]; then
                echo "Copying MOUL files..."
                cp -r "$HOME/uru-live/drive_c/Program Files/Uru Live" "$SHARDFOLDER/"
                mv "$SHARDFOLDER/Uru Live" "$SHARDFOLDER/TOC-Moul"
            fi

            echo "Launching the installer..."
            WINEPREFIX="$SHARDPREFIX" wine start /unix "$INSTALLDIR/TOC-Moul.exe" >> $HOME/uru-wine.log 2>&1
            echo "Advance the installer with the mouse, the keyboard may be intercepted by the script."
            echo "When the installation and updating is done, press any key to continue."
            read -n 1 -s -r

            read -p "Do you wish to add the 'opencave' and 'opencave-repair' aliases to $BASHFILE ? [y/n] " yn
            if [[ $yn == "y" || $yn == "Y" ]]; then
                echo "alias opencave=\"WINEPREFIX=$SHARDPREFIX wine start /unix $SHARDPREFIX/drive_c/Program\ Files/TOC-Moul/UruLauncher.exe\"" >> $HOME/$BASHFILE
                echo "alias opencave-repair=\"WINEPREFIX=$SHARDPREFIX wine start /unix $SHARDPREFIX/drive_c/Program\ Files/TOC-Moul/UruLauncher.exe /ServerIni=repair.ini /Repair\"" >> $HOME/$BASHFILE
            fi
            ;;
        4)
            SHARDPREFIX="$HOME/uru-minkata"
            SHARDFOLDER="$SHARDPREFIX/drive_c/Program Files"

            yn="n"
            if [ -d "$SHARDPREFIX" ]; then
                read -p 'The Minkata shard is already installed! Do you want to DELETE the prefix and reinstall? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                read -p 'Are you sure? [y/n] ' yn
                if ! [[ $yn == "y" || $yn == "Y" ]]; then
                    continue
                fi
                rm -r "$SHARDPREFIX"
            fi

            INSTALLDIR="$HOME/uru-installers"
            mkdir -p "$INSTALLDIR" && cd "$INSTALLDIR"

            echo "Installing the Minkata testing shard..."
            WINEARCH=win32 WINEPREFIX="$SHARDPREFIX" winetricks vcrun6 >> $HOME/uru-wine.log 2>&1

            if [ -d "$HOME/uru-live/drive_c/Program Files/Uru Live" ]; then
                echo "Copying MOUL files..."
                cp -r "$HOME/uru-live/drive_c/Program Files/Uru Live" "$SHARDFOLDER/"
                mv "$SHARDFOLDER/Uru Live" "$SHARDFOLDER/Minkata"
            else
                mkdir "$SHARDFOLDER/Minkata"
            fi

            cd "$SHARDFOLDER/Minkata/"
            rm UruLauncher.exe

            echo "Downloading the patched launcher..."
            curl -L -O "https://foundry.openuru.org/jenkins/job/CWE-ou-minkata-Compile/lastSuccessfulBuild/BuildType=External,Platform=Windows2k3Builder/artifact/MOULOpenSourceClientPlugin/Plasma20/MsDevProjects/Plasma/Apps/plUruLauncher/Release/UruLauncher.exe"
            chmod 755 UruLauncher.exe

            echo "Launching the game for patching..."
            WINEPREFIX="$SHARDPREFIX" wine start /unix "$SHARDFOLDER/Minkata/UruLauncher.exe" >> $HOME/uru-wine.log 2>&1
            echo "When the patching is done, press any key to continue."
            read -n 1 -s -r

            read -p "Do you wish to install Minkata Alpha too ? [y/n] " myn
            if [[ $myn == "y" || $myn == "Y" ]]; then
                cp -r "$SHARDFOLDER/Minkata/" "$SHARDFOLDER/MinkataA/"
                cd "$SHARDFOLDER/MinkataA/"
            fi

            read -p "Do you wish to add the 'minkata' alias to $BASHFILE ? [y/n] " yn
            if [[ $yn == "y" || $yn == "Y" ]]; then
                echo "alias minkata=\"WINEPREFIX=$SHARDPREFIX wine start /unix $SHARDPREFIX/drive_c/Program\ Files/Minkata/UruLauncher.exe\"" >> $HOME/$BASHFILE

                if [[ $myn == "y" || $myn == "Y" ]]; then
                    echo "Adding the 'minkatalpha' alias too..."
                    echo "alias minkatalpha=\"WINEPREFIX=$SHARDPREFIX wine start /unix $SHARDPREFIX/drive_c/Program\ Files/MinkataA/UruLauncher.exe /GateKeeperSrv=70.91.173.88:14717 /FileSrv=70.91.173.88:14717 /AuthSrv=70.91.173.88:14717\"" >> $HOME/$BASHFILE
                fi
            fi
            ;;
        5)
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

