source config-usb.sh

CONFIG_DIRS=`dirname $BASH_SOURCE`

HDINSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-intel-corei7-64.tar.bz2"

HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-intel-corei7-64.tar.bz2:vty=2 \
                      ${ARTIFACTS_DIR}/cube-domE-intel-corei7-64.tar.bz2:monitored:console:vty=3:net=1 \
"
#NETWORK_DEVICE="wlan0"
NETWORK_DEVICE="wlp1s0"

#HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-intel-corei7-64.tar.bz2"
INSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-intel-corei7-64.tar.bz2"
