Quick start instructions to build Wind River Pulsar Linux
for the Raspberry Pi 2 & 3.

For a more guides, examples and information please see:
https://knowledge.windriver.com/?cid=pulsar_lx

For official images please visit:
http://pulsar.windriver.com

############## Quick start clip here ###################
git clone -b master --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core

######### The first time only, check for required host packages #########
./scripts/host_package_install.sh --install --yes
#########################################################################

. init-raspberrypi-env
bitbake cube-desktop cube-dom0 cube-essential

# Build a self-bootable image for the Raspberry Pi 2 & 3 board
sudo ../overc-installer/sbin/cubeit --force    --config `pwd`/../install_templates/raspberrypi/RaspberryPi-live.sh --target-config RaspberryPi-live.sh --artifacts `pwd`/tmp/deploy/images/raspberrypi2 pulsar-raspberrypi.img

# Then dd it to an usb stick or sd card and boot up Pulsar directly on target

### login: root  password: incendia

# Note: Audio controls with Pulse Audio
#       From command line run: alsamixer
#       For UI run: pavucontrol
#       For UI desktop control add the PulseAudio control pannel:
#          Right click in the middle of the bar at the top of the screen
#          Panel->Add New Items->PulseAudio Plugin ## then click Add
