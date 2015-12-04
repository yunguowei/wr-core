source config-usb.sh

INSTALL_DTB="${ARTIFACTS_DIR}/uImage-zynq-picozed.dtb"
INSTALL_BOOTLOADER="$BASEDIR/../../layers/xilinx-zynq/bootloader/Pulsar/BOOT-PZ7020.BIN"

CONFIG_DIRS=`dirname $BASH_SOURCE`
