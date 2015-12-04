source config-usb.sh

INSTALL_DTB="${ARTIFACTS_DIR}/uImage-zynq-mini-itx-adv7511-pcie.dtb"
INSTALL_BOOTLOADER="$BASEDIR/../../layers/xilinx-zynq/bootloader/Pulsar/BOOT-MITX7045.BIN"

CONFIG_DIRS=`dirname $BASH_SOURCE`

