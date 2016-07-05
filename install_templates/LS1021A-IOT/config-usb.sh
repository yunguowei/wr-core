######################################################################
# Define some configuration variables

# set this variable 
INITRAMFS_EXTRAS=""

# set artifacts dir to the location of the kernel, image, etc.
if [ -z "${ARTIFACTS_DIR}" ]; then
    ARTIFACTS_DIR=""
fi

INSTALL_KERNEL="${ARTIFACTS_DIR}/uImage"
INSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-fsl-ls10xx.tar.bz2"
INSTALL_MODULES=""
INSTALL_INITRAMFS="${ARTIFACTS_DIR}/cube-builder-initramfs-fsl-ls10xx.cpio.gz"

INSTALL_GRUBHDCFG="grub-hd.cfg"
INSTALL_GRUBUSBCFG="grub-usb.cfg"
INSTALL_GRUBCFG="${INSTALLER_FILES_DIR}/${INSTALL_GRUBUSBCFG}"

INSTALL_FILES="${INSTALL_KERNEL} ${INSTALL_ROOTFS} ${INSTALL_MODULES} ${INSTALL_GRUBCFG}"

BOARD_NAME="fsl-ls10xx"

NETWORK_DEVICE="all"

HDINSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-fsl-ls10xx.tar.bz2"

HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-fsl-ls10xx.tar.bz2:vty=2 \
                      ${ARTIFACTS_DIR}/cube-desktop-fsl-ls10xx.tar.bz2:monitored:console:vty=3 \
"
INSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-fsl-ls10xx.tar.bz2"

# Uncomment to specify path to init.pp
#INSTALL_PUPPET_DIR="puppet"

## List of prerequisite files for the installer to check
PREREQ_FILES="${INSTALL_FILES}"
EVAL_NAME="Evaluation - OverC"

BOOTPART_START="63s"
BOOTPART_END="250M"
BOOTPART_FSTYPE="fat32"
BOOTPART_LABEL="boot"

ROOTFS_START="250M"
ROOTFS_END="-1"	# Specify -1 to use the rest of drive
ROOTFS_FSTYPE="ext2"
ROOTFS_LABEL="rootfs"

USBSTORAGE_BANNER="USB Creator for the Hard Drive Installer
--------------------------------------------------------------------------------
$EVAL_NAME
--------------------------------------------------------------------------------"

USBSTORAGE_INTRODUCTION="
This script will erase all data on your USB flash drive and configure it to boot
the Wind River Hard Drive Installer.  This installer will then allow you to
install a working system configuration on to your internal hard drive.
"

INSTALLER_COMPLETE="Installation is now complete"

CONFIRM_INSTALL=1
CONFIRM_REBOOT=0

CMD_GRUB_INSTALL="/usr/sbin/grub-install"

######################################################################
# Define some debug output variables

# Debug Levels - fixed values
DEBUG_SILENT=0
DEBUG_CRIT=1
DEBUG_WARN=2
DEBUG_INFO=4
DEBUG_VERBOSE=7

# Set your default debug level
: ${DEBUG_DEFAULT:=${DEBUG_INFO}}

# Dynamic debug level
DEBUG_LEVEL=${DEBUG_DEFAULT}

: ${TRACE:=0}

export X86_ARCH=false
