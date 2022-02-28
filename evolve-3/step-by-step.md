Part 1: BIOS Configuration
=====

Turn the computer on. Hold ESC or DEL to enter BIOS config.

`Chipset > South Bridge`:
* `OS Selection` -> `Android`; this gets most of the necessary settings to make stuff just work

`Chipset > South Cluster Configuration > USB Configuration`:
* `XHCI Pre-Boot Driver` -> `Enabled`
* `XHCI Mode` -> `Enabled`
* `USB HSIC1 Support` -> `Enabled`
* `USB SSIC1 Support` -> `Enabled`; leave the options that pop up when you enable this alone
* `XDCI Support` -> `PCI Mode`
* `XHCI Disable Compliance Mode` -> `FALSE`

`Boot`:
* `Setup Prompt Timeout` -> `2`; make it a little bit easier to get in the BIOS

Once finished, go to `Save & Exit` and hit `Save Changes and Reset`.

> **Changing the wrong thing can lock you out of the BIOS because the computer kind of sucks**. 
> If this happens, you need to remove the back panel, unplug the battery, and hold the power button for 10 seconds.
> Doing so resets the BIOS to factory settings.

Part 2: OS Install
=====

With the computer off, plug in a USB drive with your choice of Linux on it.  These steps assume it is Ubuntu.

Turn the computer on. Hold ESC or DEL to enter BIOS config.

Go to `Save & Exit` and choose the USB bootable drive from under `Boot Override`.

Choose the "try it out" mode. Wait for it to load (it may be slow, because USB is slow).

Integrated wifi is inoperable, so plug in ethernet (or some other kind of networking). 

Confirm other stuff works:

* Keyboard. Function keys/shortcuts. "Numpad". Numlock/Capslock.
* Touchpad. Touchpad clicking. One finger "touch clicking". Two finger "right clicking". Pinch-zooming (try it in Firefox). Three finger swipe gestures.
* Sound (play a YouTube video?). Headphone jack.
* HDMI port.
* Bluetooth.
* Mobile broadband is detected as a feature (though it will be "unavailable").
* MicroSD card reader.

If everything is OK, install the OS. Tell it to erase and use the whole disk. *Do not encrypt the drive* (it's slow enough as is). Let it update as it installs.

> *Optional:* When configuring the drive, increase swap space to 4 GB. This serves as "fallback" RAM, and may help the computer stay stable if it runs out of its paltry RAM.

Follow through on the instructions. Restart and boot into the new OS.

Re-check the things from above. Additionally, make sure "Suspend" (sleep mode) works.

Check for updates and install any available ones. Just in case.

Part 3: Wifi Drivers
=====

The Evolve III uses a `RTL8723DU` chipset, which does not have baked-in drivers, and which Ubuntu cannot (currently) automatically install.

> If Ubuntu could install it, you would find it with the `Additional Drivers` application. You could try that first, if you wish to confirm. Make sure you have an internet connection when you launch it.

[There is an open source, 3rd party driver that supports this chipset](https://github.com/lwfinger/rtl8723du). You need to download, compile, install, and enable it manually though. *This all must be done from a terminal.*

Open a terminal. Use these commands to make sure you have admin (root) access. It should reply to the first command with your username, and to the second with `root`.

    whoami
    sudo whoami

Install the pre-requisite packages for building/installing the driver.

    sudo apt update
    sudo apt install make gcc linux-headers-$(uname -r) build-essential git

Create and enter a `wifi` directory in your home directory, where all the magic will happen.

    mkdir -p ~/wifi
    cd ~/wifi

Fetch the Git repository for the wifi driver, and enter the directory it created.

    git clone https://github.com/lwfinger/rtl8723du.git
    cd rtl8723du

Compile it. This will take a while.

    make

Install it into your OS.

    sudo make install

Manually load the kernel module containing the driver, to make sure it works.

    sudo modprobe 8723du

You should now be able to use wifi.

Reboot. The module should load automatically and you should have wifi immediately.

> **⚠️ Note for the future: ⚠️** Whenever OS updates happen in the future, if the kernel is updated, wifi may break. In that case, the driver needs to be rebuilt and reinstalled.

Part 4: User Setup and Customization
=====

Have fun! :D