Quick start instructions.

--- Intel Minnow Board BSP ---

git clone --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core
. init-intel-x86-env
bitbake cube-domE cube-dom0 cube-essential

# Build a bootable image
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/intel-x86/config-live.sh --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 pulsar.img

# Build an installer image
#DEV=/dev/NBD_DEVICE  or a USB storage device
sudo ../overc-installer/sbin/cubeit --force --config `pwd`/../install_templates/intel-x86/config-live.sh --artifacts `pwd`/tmp/deploy/images/intel-corei7-64 $DEV

### login: root  password: incendia

#----------------OR-------------------#

--- Xilinx-Zynq BSP ---

git clone --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core
. init-xilinx-zynq-env
bitbake cube-server cube-dom0 cube-essential

### login: root  password: incendia

