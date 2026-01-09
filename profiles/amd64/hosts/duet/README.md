# Lenovo IdeaPad Duet 3i 10IGL5
The Lenovo IdeaPad Duet 3i (10IGL5) was a 10.3" detachable tablet from Lenovo. Unlike the armv8 based IdeaPad Duet Chromebooks, the 3i came with an Intel x86_64 processor from the Gemini Lake series.


* CPU - Intel Gemini Lake, either:
	* Celeron N4020 (dual-core)
		* 4GB RAM / 64GB eMMC / UHD Graphics 600
	* Pentium Silver N5030 (quad-core)
		* 8GB RAM / 128GB eMMC / UHD Graphics 605
* GPU: Intel UHD Graphics 60x
	* VA-API
	* Vulkan
	* OpenCL
	* OpenGL
* Display:
	* 1200x1920px, 10.3", 320 nit, IPS panel
	* Non-touch, Touch, or Pen support
* Cameras:
	* Front: 720p30
	* Rear: 1080p30
* USB ports: 2x USB-C
* microSD card slot
* Optional 4G-LTE modem (Intel XMM7360-PCI, Fibocom GL-850)


make.conf
---------
```sh
COMMON_FLAGS="-O2 -pipe -march=x86-64-v2 -mtune=goldmont-plus"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"

MICROCODE_SIGNATURES="-s 0x000706a8"
```
Storage
-------
The Lenovo IdeaPad Duet 3i will boot from the internal eMMC or an external USB flash drive. It cannot be coerced into booting from the microSD card.
### eMMC
```
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
```

If these are built as modules, add ``mmc_block`` and ``sdhci-pci`` to your initramfs.
### microSD card
```
CONFIG_MISC_RTSX=y
CONFIG_MISC_RTSX_PCI=y
```

Display
-------
### Firmware
```
i915/glk_dmc_ver1_04.bin
i915/glk_guc_70.1.1.bin
i915/glk_huc_4.0.0.bin
```
### Driver
The GPU can run with the generic modesetting driver. However, in my experience, the modesetting driver exhibited a lot of (vertical) screen tearing when playing videos and scrolling a browser. The suggestion is to run the Intel DDX driver, `x11-drivers/xf86-video-intel`.
### Rotation
The 1200x1920 display is mounted sideways to the "usual" laptop position. This may mean some unconfigured screens may not be as usable as a traditional laptop.
#### Console
```
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y

fbcon=rotate:1

/sys/class/graphics/fbcon/rotate
```
Note that plymouth's splash does not follow framebuffer console rotation.

#### X11
/etc/X11/xorg.conf.d/20-intel.conf
```
Section "Monitor"
	Identifier "DSI1"
	Option "PreferredMode" "1200x1980"
	Option "Rotate" "right"
EndSection
```

#### Wayland
*TBD*

### Touchscreen
```
CONFIG_PINCTRL=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_GEMINILAKE=y
```

WWAN
----
### Upstream driver (6.2+)
```
CONFIG_WWAN=m
CONFIG_IOSM=m
```

From Linux 6.2, the IOSM driver exposes the RPC interface for configuring the modem.

At time of writing, released versions ModemManager (1.24) cannot configure the modem over this interface.
A pre-release 1.25.95-dev does have the ability to configure the modem,
or one could use a script like `rpc/open_xdatachannel.py` from [xmm7360-pci](https://github.com/xmm7360/xmm7360-pci).

### External/Out-of-Tree driver
For earlier kernel versions, it should be possible to use the xmm7360-pci driver to expose thrpce RPC interface, and the scripts to configure it.

Cameras
-------
``CONFIG_USB_VIDEO_CLASS=y``

Both the front and rear cameras are USB Video Class devices.

Keyboard
--------
### Bluetooth
When detaching the keyboard and connecting over bluetooth, keys may not register. The workaround is to enable a keyboard lock LED (Caps Lock or Num Lock) before disconnecting the keyboard. The detachable keyboard does not have a Num Lock key or Numpad.

If running sddm with KDE, add this to your sddm.conf:
```ini
[General]
Numlock=on
InputMethod=qtvirtualkeyboard
```
You may also want to set KDE's keyboard NumLock state to "Always On".

Wifi
----
Intel CNVi WiFi
Firmware:  ``iwlwifi-9000-pu-b0-jf-b0-46.ucode``
BT firmwares: ``ibt-17-16-1.sfi``, ``ibt-17-16-1.ddc``

Audio
-----
Gemini Lake supports Sound Open Firmware. The firmware can be found in the package `sys-firmware/sof-firmware`.
