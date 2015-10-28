source ../config-usb.sh

INSTALL_DTB="${ARTIFACTS_DIR}/uImage-zynq-picozed.dtb"
INSTALL_BOOTLOADER="$BASEDIR/../../layers/xilinx-zynq/bootloader/Pico_BOOT_SD.BIN"

CONFIG_DIRS=`dirname $BASH_SOURCE`
