source config-usb.sh

INSTALL_DTB="${ARTIFACTS_DIR}/uImage-zynq-zed.dtb"
INSTALL_BOOTLOADER="$BASEDIR/../../layers/xilinx-zynq/bootloader/Pulsar/BOOT-MZ7010.BIN"

CONFIG_DIRS=`dirname $BASH_SOURCE`
