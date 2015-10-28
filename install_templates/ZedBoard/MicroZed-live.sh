source config-usb.sh

INSTALL_DTB="${ARTIFACTS_DIR}/uImage-zynq-zed.dtb"
INSTALL_BOOTLOADER="$BASEDIR/../../layers/xilinx-zynq/bootloader/Micro_boot.bin"

CONFIG_DIRS=`dirname $BASH_SOURCE`
