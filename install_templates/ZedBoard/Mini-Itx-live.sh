source config-usb.sh

INSTALL_DTB="${ARTIFACTS_DIR}/uImage-zynq-mini-itx-adv7511.dtb"
INSTALL_BOOTLOADER="$BASEDIR/../../layers/xilinx-zynq/bootloader/boot_mini-itx.bin"

CONFIG_DIRS=`dirname $BASH_SOURCE`

