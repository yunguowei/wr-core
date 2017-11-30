Quick start instructions to build Wind River Pulsar Linux
for the NXP LS1021a-IOT board.

For a more guides, examples and information please see:
https://knowledge.windriver.com/?cid=pulsar_lx

For official images please visit:
http://pulsar.windriver.com

############## Quick start clip here ###################

git clone -b pulsar-x --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core

######### The first time only, check for required host packages #########
./scripts/host_package_install.sh --install --yes
#########################################################################

# Create a work space
. init-fsl-ls10xx-env

# Build the gateway software
bitbake cube-gw cube-dom0 cube-essential

# Build a bootable image for FSL LS1021A-IOT board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/LS1021A-IOT/LS1021A-IOT-gw-live.sh \
   --target-config LS1021A-IOT-gw-live.sh \
   --artifacts `pwd`/tmp/deploy/images/fsl-ls10xx pulsar8-fsl-ls1021aiot.img

# And finally dd it to a micro sd card and boot up Pulsar directly on target

### login: root  password: incendia
