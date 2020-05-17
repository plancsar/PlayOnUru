# PlayOnUru
A collection of PlayOnLinux/PlayOnMac scripts (POL-\*) to install Uru Live and shards. You will need to run them from inside the Launcher: <code>Tools</code> menu > <code>Run a local script</code>, then select the script you want to run. You will get a warning that the signature is not valid: you can ignore it, this is normal for custom script.

<b>Minkata</b>: the script tries to copy the data files from the Uru Live prefix, if it exists, otherwise it installs Uru Live, then Minkata on top of it.

<b>The Open Cave</b>: the script tries to copy the data files from the Uru Live prefix, if it exists.

<b>Gehn Shard</b>: the script tries to copy the data files from the Uru Live prefix, if it exists.
If the game fails to delete the old patcher executable, just keep trying relaunching it, after a couple of attempts it should manage.

<b>Deep Island</b>: currently based on the GOG installer only. The first time you launch the game, you'll get a few error alert, but you should be able to ignore them and continue.

# Other scripts
Basic Bash install scripts for Linux and macOS, using only Wine (preferably from WineHQ) and winetricks.

<b>shardinstall</b>: to install MOULa, Gehn, Open Cave and Minkata. If MOULa is installed first, the other options will copy the game files from it.

<b>gehninstall</b>: superseded by <i>shardinstall</i>.

<b>deepinstall</b>: to install and configure a Deep Island client, possibly (but not currently) including the conversion of the Myst V Ages. Currently based on the GOG installer only. The full installer path should be inputted when requested.
