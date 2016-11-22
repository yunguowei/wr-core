Quick start instructions to build Wind River Pulsar Linux
for the Intel Apollolake boards
(Leafhill and OxBow hill)

For a more guides, examples and information please see:
https://knowledge.windriver.com/?cid=pulsar_lx

For official images please visit:
http://pulsar.windriver.com

############## Quick start clip here ###################
git clone -b pulsar-8 --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core

######### The first time only, check for required host packages #########
./scripts/host_package_install.sh --install --yes
#########################################################################

. init-intel-apollolake-env
bitbake cube-desktop cube-dom0 cube-essential cube-gw

# Build a self-bootable image with Desktop GUI for Apollolake board
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/Intel_Apollolake/Intel-Apollolake-Desktop-live.sh --target-config Intel-Apollolake-Desktop-live.sh --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 pulsar8-intelapollolakedesktop.img

# Build a self-bootable image with gateway support for Apollolake board
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/Intel_Apollolake/Intel-Apollolake-gw-live.sh --target-config Intel-Apollolake-gw-live.sh  --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 pulsar8-intelapollolakegw.img

# Then dd it to an usb stick or sd card and boot up Pulsar directly on target

# Or build an installer image or USB stick with Desktop GUI support
#DEV=/dev/NBD_DEVICE  or a USB storage device
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/Intel_Apollolake/Intel-Apollolake-Desktop-live.sh --target-config `pwd`/../install_templates/Intel_Apollolake/Intel-Apollolake-Desktop-live.sh --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 $DEV

# Or build an installer image or USB stick with Gateway support
#DEV=/dev/NBD_DEVICE  or a USB storage device
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/Intel_Apollolake/Intel-Apollolake-gw-live.sh --target-config `pwd`/../install_templates/Intel_Apollolake/Intel-Apollolake-gw-live.sh --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 $DEV

# Then plug the USB installer stick into target, boot it up and run the
# installation(Here suppose the storage device you want to install to is $DEV):
cd /opt/installer
./sbin/cubeit-installer -b images/cube-essential-* $DEV
# After installation, reboot the target and unplug the usb installer stick, Pulsar will
# boot up from installed local storage device

### login: root  password: root

### Supported Features 
-------------------------------------------------------------------------------

The following BSP features are validated and supported on boards where
the corresponding h/w features exist.

  o General Platform
	+ perf: H/W based PMU

  o Bus
	+ PCI/PCI-Express
	+ I2C/SMBus:
		+ Intel i801 family I2C/SMBus controller

  o Network
        + Intel IGB Ethernet:
                + Intel Corporation I210 Gigabit Network Connection

  o USB
	+ USB Host:
		+ USB 3.0 XHCI controller

  o Storage
	+ SATA: AHCI SATA controller
	+ eMMC/SDIO/SD card: Secure Digital Host Controller

  o Multimedia
	+ Graphics:
		+ Intel Corporation I915 Integrated Graphics Controller

	+ Intel HD Audio

  o Power Management
	+ CPU Freq: ACPI P-state
	+ CPU Idle: ACPI C-state

  o Misc Devices
	+ UART: 8250/16550A compatible serial port
	+ RTC: PC-style CMOS RTC
	+ Input deivce
		+ USB mouse & keyboard
	+ Watchdog: Intel iTCO H/W Watchdog timer
	+ HW Monitor: Intel CPU core temperature sensor

  o Graphics Acceleration:
	WRLinux has integrated the following packages to support 2D/3D graphics acceleration

        xserver-xorg-1.17.2
        libdrm-2.4.67
        mesa-11.2.1
        xf86-video-intel-2.99.917

### Unsupported Features
---------------------------------------------------------

The following features are not supported or validated:

	x IPU
	x Media Engine
	x USB OTG
	x SPI
