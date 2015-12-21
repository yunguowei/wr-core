Quick start instructions to build Wind River Pulsar Linux
for the NXP LS1021a-IOT board.

For a more guides, examples and information please see:
https://knowledge.windriver.com/?cid=pulsar_lx

For official images please visit:
http://pulsar.windriver.com

############## Quick start clip here ###################

git clone --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core

######### The first time only, check for required host packages #########
./scripts/host_package_install.sh --install --yes
#########################################################################

# Decide if you want to enable the proprietary licensed ethernet switch
export ALLOW_PROPRIETARY=1

# Create a work space
. init-fsl-ls10xx-env

#### NOTE: This has re-distribution ramifications ####
# From an official image, in order to use the ethernet switch
# you must execute after booting:
#       smart install rtlswitch
#       reboot
# Or if you want to build with the proprietary component in the image
# You can use update the local.conf as shown below, or build
# the RPM with: bitbake rtlswitch
echo 'CUBE_GW_EXTRAS += "rtlswitch"' >> conf/local.conf

# Build the gateway software
bitbake cube-gw cube-dom0 cube-essential

# Build a bootable image for FSL LS1021A-IOT board
sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/LS1021A-IOT/LS1021A-IOT-gw-live.sh \
   --target-config LS1021A-IOT-gw-live.sh \
   --artifacts `pwd`/tmp/deploy/images/fsl-ls10xx pulsar7-fsl-ls1021aiot.img

# And finally dd it to a micro sd card and boot up Pulsar directly on target

### login: root  password: incendia
