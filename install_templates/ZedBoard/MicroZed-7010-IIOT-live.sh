source config-usb.sh

INSTALL_DTB="${ARTIFACTS_DIR}/uImage-zynq-microzed-iiot.dtb"
INSTALL_BOOTLOADER="$BASEDIR/../../layers/xilinx-zynq/bootloader/Pulsar/BOOT-MZ7010-IIOT.BIN"

CONFIG_DIRS=`dirname $BASH_SOURCE`
