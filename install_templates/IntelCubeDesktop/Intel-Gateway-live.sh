source config-usb.sh

CONFIG_DIRS=`dirname $BASH_SOURCE`

SCREEN_GETTY_CONSOLE=ttyS0,115200

HDINSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-intel-corei7-64.tar.bz2"

HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-intel-corei7-64.tar.bz2:console:vty=2 \
                      ${ARTIFACTS_DIR}/cube-gw-intel-corei7-64.tar.bz2:console:vty=3,active:net=1:cube.device.mgr=self \
"

NETWORK_DEVICE="eth+ wl+ en+"

#HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-intel-corei7-64.tar.bz2"
INSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-intel-corei7-64.tar.bz2"

export LOCAL_CUSTOM_HDD_POST_FUNCS="my_local_post_func"

my_local_post_func()
{
        #copy the HAL id&passwd from dom0 to cube-srver/cube-gw/cube-desktop
	CNS="cube-server cube-gw cube-desktop"
        for c in ${CNS}; do
                if [ -d ${TMPMNT}/opt/container/$c/rootfs ]; then
                        cat ${TMPMNT}/opt/container/dom0/rootfs/var/lib/cube-cmd-server/auth.db > ${TMPMNT}/opt/container/$c/rootfs/etc/cube-cmd.auth
                fi
        done
}
