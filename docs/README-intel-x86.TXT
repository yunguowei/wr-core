Quick start instructions to build Wind River Pulsar Linux
for the Intel Minnow Board Max and Intel Compute Stick
(Cherry Trail and Bay Trail)

For a more guides, examples and information please see:
https://knowledge.windriver.com/?cid=pulsar_lx

For official images please visit:
http://pulsar.windriver.com

############## Quick start clip here ###################
git clone -b pulsar-lts-17 --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core

######### The first time only, check for required host packages #########
./scripts/host_package_install.sh --install --yes
#########################################################################

# Init the environment
. init-intel-x86-env

# Build the images
bitbake cube-gw-flatpak-runtime

# Then dd it to an usb stick or sd card and boot up Pulsar directly on target

### login: root  password: root

