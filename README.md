# MiSTer GroovyHelper
[GroovyHelper](https://github.com/kconger/MiSTer_GroovyHelper) allows launching of Groovy_MiSTer enabled emulators using MGL files.

Current Features
-------
- Starts and Stops GroovyMAME on another host from a MGL file, tested on Linux and Macos

Requirements
-------
- [Groovy_MiSTer](https://github.com/psakhis/Groovy_MiSTer) installed on your MiSTer. Groovy Core must be installed in _Utility directory otherwise the MGL will need to be modified with the new path.
- [GroovyMAME](https://github.com/antonioginer/GroovyMAME) installed and configured on another host
- SSH Server on your Groovy emulator host
- SSH Key setup between your MiSTer and Groovy emulator host

Installation
-------
Add the following entry to your 'downloader.ini' then run 'update_all.sh'
```
[groovyhelper_files]
db_url = https://raw.githubusercontent.com/kconger/MiSTer_GroovyHelper/master/groovyhelperdb.json
```

Run "update_all.sh" on your MiSTer. 

Modify "/media/fat/groovyhelper/groovyhelper-user.ini" for your enviroment. 

Run "/media/fat/groovyhelper/install_groovyhelper.sh" to install the service

Copy the 'GroovyMAME.mgl' from this repo to a Core folder, ie. _Utility

SSH Key Setup
-------
On your Groovy Emulator host make sure you have SSH server enabled and running.

On your MiSTer generate a SSH key without a password and save to its default location.
```
ssh-keygen -t ed25519
```

Copy the key to your Groovy emulator host using the user who will run the emulator.
```
ssh-copy-id username@your_mame_host
```

Credits
-------

MiSTer service code and update scripts from the [MiSTer_tty2oled](https://github.com/venice1200/MiSTer_tty2oled) project with modifications.
