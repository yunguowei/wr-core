source config-usb.sh

CONFIG_DIRS=`dirname $BASH_SOURCE`

SCREEN_GETTY_CONSOLE=ttyS0,115200

HDINSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-intel-corei7-64.tar.bz2"

HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-intel-corei7-64.tar.bz2:console:vty=2:net=1 \
                      ${ARTIFACTS_DIR}/cube-desktop-intel-corei7-64.tar.bz2:vty=3:net=3 \
"

NETWORK_DEVICE="enp0s3"
NETWORK_DEVICE_CLASSES="eth+ wl+ en+"

#HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-intel-corei7-64.tar.bz2"
INSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-intel-corei7-64.tar.bz2"
