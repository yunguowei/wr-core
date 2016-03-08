Quick start instructions to build Wind River Pulsar Linux
for the Avnet Zed boards

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

. init-xilinx-zynq-env
bitbake cube-server cube-dom0 cube-essential

# Build a bootable image for PicoZed 7010 board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/ZedBoard/PicoZed-7010-live.sh --target-config PicoZed-7010-live.sh \
   --artifacts `pwd`/tmp/deploy/images/xilinx-zynq pulsar7-avnet-picozed-7010.img

# Build a bootable image for PicoZed 7015 board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/ZedBoard/PicoZed-7015-live.sh --target-config PicoZed-7015-live.sh \
   --artifacts `pwd`/tmp/deploy/images/xilinx-zynq pulsar7-avnet-picozed-7015.img

# Build a bootable image for PicoZed 7020 board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/ZedBoard/PicoZed-7020-live.sh --target-config PicoZed-7020-live.sh \
   --artifacts `pwd`/tmp/deploy/images/xilinx-zynq pulsar7-avnet-picozed-7020.img

# Build a bootable image for PicoZed 7030 board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/ZedBoard/PicoZed-7030-live.sh --target-config PicoZed-7030-live.sh \
   --artifacts `pwd`/tmp/deploy/images/xilinx-zynq pulsar7-avnet-picozed-7030.img

# Build a bootable image for Mini-Itx 7045 board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/ZedBoard/Mini-Itx-7045-live.sh --target-config Mini-Itx-7045-live.sh \
   --artifacts `pwd`/tmp/deploy/images/xilinx-zynq pulsar7-avnet-miniitx-7045.img

# Build a bootable image for Mini-Itx 7100 board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/ZedBoard/Mini-Itx-7100-live.sh --target-config Mini-Itx-7100-live.sh \
   --artifacts `pwd`/tmp/deploy/images/xilinx-zynq pulsar7-avnet-miniitx-7100.img

# Build a bootable image for MicroZed 7010  board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/ZedBoard/MicroZed-7010-live.sh --target-config MicroZed-7010-live.sh \
   --artifacts `pwd`/tmp/deploy/images/xilinx-zynq pulsar7-avnet-microzed-7010.img

# Build a bootable image for MicroZed 7020  board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/ZedBoard/MicroZed-7020-live.sh --target-config MicroZed-7020-live.sh \
   --artifacts `pwd`/tmp/deploy/images/xilinx-zynq pulsar7-avnet-microzed-7020.img

# And finally dd it to a micro sd card and boot up Pulsar directly on target

### login: root  password: incendia

