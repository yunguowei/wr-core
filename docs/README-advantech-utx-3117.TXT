Quick start instructions to build Wind River Pulsar Linux
for Advantech UTX-3117 project

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

. init-advantech-utx-3117-env
bitbake cube-dom0 cube-essential cube-gw

# Build a self-bootable image with gateway support for UTX-3117 board
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/Intel_Apollolake/Intel-Apollolake-gw-live.sh --target-config Intel-Apollolake-gw-live.sh  --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 pulsar8-UTX-3117-gw.img

# Then dd it to an usb stick or sd card and boot up Pulsar directly on target

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

