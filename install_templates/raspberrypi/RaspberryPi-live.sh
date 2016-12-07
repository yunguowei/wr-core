source config-usb.sh

#INSTALL_DTB="${ARTIFACTS_DIR}/uImage-zynq-zed.dtb"
#INSTALL_BOOTLOADER="$BASEDIR/../../layers/xilinx-zynq/bootloader/Pulsar/BOOT-MZ7010.BIN"

CONFIG_DIRS=`dirname $BASH_SOURCE`
FDISK_PARTITION_LAYOUT="$CONFIG_DIRS/fdisk-4-partition-layout.txt"
MY_LOCAL_FUNC_DIR=`readlink -f ${CONFIG_DIRS}`
#FUNCTIONS_TO_COPY="${FUNCTIONS_TO_COPY} ${MY_LOCAL_FUNC_DIR}/functions-local.sh"
export LOCAL_POST_FUNCTION_DEFS="${MY_LOCAL_FUNC_DIR}/functions-local.sh"
export LOCAL_CUSTOM_HDD_POST_FUNCS="my_local_post_func"
