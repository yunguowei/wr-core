source config-usb.sh

CONFIG_DIRS=`dirname $BASH_SOURCE`

HDINSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-intel-corei7-64.tar.bz2"

HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-intel-corei7-64.tar.bz2:vty=2:mergepath=/usr,essential \
                      ${ARTIFACTS_DIR}/cube-desktop-intel-corei7-64.tar.bz2:monitored:console:vty=3:net=1:mergepath=/usr,essential,dom0 \
"
NETWORK_DEVICE="all"

#HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-intel-corei7-64.tar.bz2"
INSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-intel-corei7-64.tar.bz2"
