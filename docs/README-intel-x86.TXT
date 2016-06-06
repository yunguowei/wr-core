Quick start instructions to build Wind River Pulsar Linux
for the Intel Minnow Board Max and Intel Compute Stick
(Cherry Trail and Bay Trail)

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

. init-intel-x86-env
bitbake cube-desktop cube-dom0 cube-essential

# Build a self-bootable image for IntelCubeDesktop board
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/IntelCubeDesktop/IntelCubeDesktop-live.sh --target-config IntelCubeDesktop-live.sh --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 pulsar8-intelcubedesktop.img
# Then dd it to an usb stick or sd card and boot up Pulsar directly on target

# Or build an installer image or USB stick
#DEV=/dev/NBD_DEVICE  or a USB storage device
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/IntelCubeDesktop/IntelCubeDesktop-live.sh --target-config IntelCubeDesktop-live.sh --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 $DEV
# Then plug the USB installer stick into target, boot it up and run the
# installation(Here suppose the storage device you want to install to is $DEV):
cd /opt/installer
./sbin/cubeit-install -b images/cube-essential-* $DEV
# After installation, reboot the target and unplug the usb installer stick, Pulsar will
# boot up from installed local storage device

### login: root  password: root

### Optionally simulate the image with kvm/qemu

kvm -drive file=pulsar8-intelcubedesktop.img,if=virtio -m 2000 -nographic -vnc :3 -serial mon:stdio -vga vmware -net user,hostfwd=tcp::4440-10.0.2.15:22,hostfwd=tcp::4441-10.0.2.15:2222 -net nic -usbdevice tablet

# Note: The terminal is your serial port, and you can access the
#       grapics console by starting: vncviewer $YOUR_SERVER_IP:3

# Note: Audio controls with Pulse Audio
#       From command line run: alsamixer
#       For UI run: pavucontrol
#       For UI desktop control add the PulseAudio control pannel:
#          Right click in the middle of the bar at the top of the screen
#          Panel->Add New Items->PulseAudio Plugin ## then click Add
