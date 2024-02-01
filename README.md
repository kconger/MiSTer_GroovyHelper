# MiSTer GroovyHelper
[GroovyHelper](https://github.com/kconger/MiSTer_GroovyHelper) allows launching of Groovy_MiSTer enabled emulators using MGL files.

#WIP Experiment

Current Features
-------
- Starts and Stops GroovyMAME on another host from a MGL file

Requirements
-------
* [Groovy_MiSTer](https://github.com/psakhis/Groovy_MiSTer)
* GroovyMAME installed on another Linux host

Installation
-------
On your Groovy Emulator machine make sure you have SSH server enabled and running.

On your MiSTer generate a SSH key without a password and save to its default location.
```
ssh-keygen -t ed25519
```

Copy the key to your Groovy Linux host using the user who will run the emulator.
```
ssh-copy-id username@your_mame_host
```

Copy the 'GroovyMAME.mgl' to a Core folder, ie. _Arcade


Credits
-------

Linux/MiSTer service code and update scripts from the [MiSTer_tty2oled](https://github.com/venice1200/MiSTer_tty2oled) project with modifications.
