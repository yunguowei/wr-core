source config-usb.sh

INSTALL_DTB="${ARTIFACTS_DIR}/uImage-ls1021a-iot.dtb"
INSTALL_BOOTLOADER="$BASEDIR/../../layers/fsl-ls10xx/bootloader/ls1021aiot/u-boot-2015/u-boot-sd-ls1021aiot-2015.01-rcw_0x20.bin"
FDISK_PARTITION_LAYOUT="$BASEDIR/../../overc-installer/sbin/fdisk-4-partition-SD-layout.txt"
INSTALL_BOOTLOADER_ENV="$BASEDIR/../../overc-installer/files/uboot-LS1021A-IOT.env.bin"

CONFIG_DIRS=`dirname $BASH_SOURCE`
MY_LOCAL_FUNC_DIR=`readlink -f ${CONFIG_DIRS}`
#FUNCTIONS_TO_COPY="${FUNCTIONS_TO_COPY} ${MY_LOCAL_FUNC_DIR}/functions-local.sh"
export LOCAL_POST_FUNCTION_DEFS="${MY_LOCAL_FUNC_DIR}/functions-local.sh"
export LOCAL_CUSTOM_HDD_POST_FUNCS="my_local_post_func"
HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-fsl-ls10xx.tar.bz2:vty=2 \
                      ${ARTIFACTS_DIR}/cube-gw-fsl-ls10xx.tar.bz2:monitored:privileged:console:vty=3 \
"
