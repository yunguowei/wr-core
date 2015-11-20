source config-usb.sh

INSTALL_DTB="${ARTIFACTS_DIR}/uImage-ls1021a-iot.dtb"
INSTALL_BOOTLOADER="$BASEDIR/../../layers/fsl-ls10xx/bootloader/ls1021aiot/u-boot-2015/u-boot-sd-ls1021aiot-2015.01-rcw_0x20.bin"

CONFIG_DIRS=`dirname $BASH_SOURCE`
