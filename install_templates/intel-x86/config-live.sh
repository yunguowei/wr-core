source config-usb.sh

CONFIG_DIRS=`dirname $BASH_SOURCE`

HDINSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-valleyisland-64.tar.bz2"

HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-valleyisland-64.tar.bz2 \
                      ${ARTIFACTS_DIR}/cube-domE-valleyisland-64.tar.bz2 \
"
#HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-valleyisland-64.tar.bz2"
INSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-valleyisland-64.tar.bz2"
