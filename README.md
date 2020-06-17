# PlayOnUru
A collection of PlayOnLinux/PlayOnMac scripts (POL-\*) to install Uru Live and shards. You will need to run them from inside the Launcher: <code>Tools</code> menu > <code>Run a local script</code>, then select the script you want to run. You will get a warning that the signature is not valid: you can ignore it, this is normal for custom script.

<b>Gehn Shard</b>: the script tries to copy the data files from the Uru Live prefix, if it exists.
If the game fails to delete the old patcher executable, just keep trying relaunching it, after a couple of attempts it should manage.

<b>Minkata</b>: the script tries to copy the data files from the Uru Live prefix, if it exists, otherwise it installs Uru Live, then Minkata on top of it.

<b>The Open Cave</b>: the script tries to copy the data files from the Uru Live prefix, if it exists.

<b>Uru CC + Drizzle</b>, <b>Deep Island</b>, <b>Open Cave PotS</b>: currently based on the 25th Anniversary app on macOS, or the GOG installer on Linux. The first time you launch the game, you'll get error alerts and crashes, but after a few attempts you should be able to continue.<br/>
The Uru CC + Drizzle will also download Drizzle32 and put in <code>$HOME/bin</code>. If Drizzle prints an alert saying it can't find the Uru folder, try closing and relaunching it.

# Other scripts
Basic Bash install scripts for Linux and macOS, using only Wine (preferably from WineHQ) and winetricks.

<b>shardinstall-moul</b>: to install MOULa, Gehn, Open Cave and/or Minkata. If MOULa is installed first, the other options will copy the game files from it.

<b>shardinstall-pots</b> (WIP): to install and configure Uru CC + Drizzle, Deep island and/or The Open Cave (PotS). Currently based on the 25th Anniversary app on macOS, or the GOG installer on Linux, which should be in the same folder as the script.
