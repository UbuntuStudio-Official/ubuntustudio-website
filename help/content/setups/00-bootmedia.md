# Boot Media Creation
## Before creating the boot media
- Download the UbuntuStudio iso image at [ubuntustudio.org](https://ubuntustudio.org/)
## USB stick (single boot)
> Ubuntu Studio desktop installation come with a built-in `Startup Disk Creator`, 
> therefore no addtional installation required.

There is various tools can be used for creating a boot media.
- [balenaEtcher](https://etcher.balena.io/#download-etcher)
- [Raspberry Pi imager](https://www.raspberrypi.com/software/)
  - this software is also available via:
    - `sudo apt install rpi-imager` - from the apt repository.
    - `sudo snap install rpi-imager` - a more recent version from the official Snap Store

## USB stick (multi boot with ventoy)
1. [Download ventoy](https://sourceforge.net/projects/ventoy/files/v1.1.10/) (futher version seems to have capability issue with bios boot)
2. use ventoy to format your usb stick
3. re-plug your usb stick and copy desired iso image into the exfat partition.

## DVD
for windows and macos, the dvd burning option is intergrated into the right-click menu.

for linux distros, k3b would be a good option.
