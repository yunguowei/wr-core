Quick start instructions to build Wind River Pulsar Linux
for the Intel Minnow Board Max

For a more guides, examples and information please see:
https://knowledge.windriver.com/?cid=pulsar_lx

For official images please visit:
http://pulsar.windriver.com

############## Quick start clip here ###################
git clone -b pulsar-7.0 --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core

######### The first time only, check for required host packages #########
./scripts/host_package_install.sh --install --yes
#########################################################################

. init-intel-x86-env
bitbake cube-domE cube-dom0 cube-essential

# Build a self-bootable image
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/MinnowBoardMax/MinnowBoardMax-live.sh --target-config MinnowBoardMax-live.sh --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 pulsar7-minnowboardmax.img
# Then dd it to an usb stick or sd card and boot up Pulsar directly on target

# Or build an installer image or USB stick
#DEV=/dev/NBD_DEVICE  or a USB storage device
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/MinnowBoardMax/MinnowBoardMax-live.sh --target-config MinnowBoardMax-live.sh --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 $DEV
# Then plug the USB installer stick into target, boot it up and run the
# installation(Here suppose the storage device you want to install to is $DEV):
cd /opt/installer
./sbin/cubeit-install -b images/cube-essential-* $DEV
# After installation, reboot the target and unplug the usb installer stick, Pulsar will
# boot up from installed local storage device

### login: root  password: incendia

### Optionally simulate the image with kvm/qemu

kvm -drive file=pulsar7-minnowboardmax.img,if=virtio -m 2000 -nographic -vnc :3 -serial mon:stdio -vga vmware

# Note: The terminal is your serial port, and you can access the
#       grapics console by starting: vncviewer $YOUR_SERVER_IP:3

