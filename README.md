# PlayOnUru
A collection of PlayOnLinux/PlayOnMac scripts to install Uru Live and shards.

<b>Uru Live</b>: currently is set to launch in a virtualized window, to prevent Wine from taking control of the whole screen. Afterward, one can set the graphics in-game (or copy the <i>config.ini</i> file, which is set to windowed mode with minimum graphic settings, into <code>Documents/Uru Live/Init/</code> ) and turn off window virtualization from <i>Settings</i> > <i>Wine</i> > <i>Configure Wine</i> > <i>Graphics</i>.

<b>Minkata</b>: it assumes the presence of the Uru Live wineprefix, to copy files from there. Same video issues as Uru Live.

<b>Gehn Shard</b>: it manages to load the login window, but fails to downloads a few files. Using the "/image" argument from <i>Configure</i> once should fix that. The script tries to copy the data files from the Uru Live prefix. Loading can be slow.

<b>The Open Cave</b>: same issues as Gehn, but the Installer seems to hang up; in that case, quit POL, relaunch it, then create the link manually from <i>Configure</i> > <i>Make a new shortcut from this virtual drive</i>.
