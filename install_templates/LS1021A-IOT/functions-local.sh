
my_local_post_func()
{
    perl -p -i -e 's#^Name=.*#Name=none#' ${TMPMNT}/etc/systemd/network/wired-network-ifnames.network
    perl -p -i -e 's#^lxc.network.*##' ${TMPMNT}/var/lib/lxc/cube-gw/config
    echo "lxc.console = /dev/ttyS0" >> ${TMPMNT}/var/lib/lxc/cube-gw/config
    echo "lxc.network.type = none" >> ${TMPMNT}/var/lib/lxc/cube-gw/config
    rm -f ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/multi-user.target.wants/named.service
    ln -sf /dev/null ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/named.service
    rm -f ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/multi-user.target.wants/systemd-networkd.service
    ln -sf /dev/null ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/systemd-networkd.service
    perl -p -i -e 's#cube-server#cube-gw#' ${TMPMNT}/etc/cube-cmd-server.conf
    perl -p -i -e 's#cube-server#cube-gw#' ${TMPMNT}/var/lib/lxc/dom0/rootfs/etc/cube-cmd-server.conf
    perl -p -i -e "s#option ifname 'wlan0'#option ifname 'eth1 eth2 wlan0'#" ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/config/network
    cat<<EOF>${TMPMNT}/var/lib/lxc/dom0/rootfs/etc/systemd/network/bridge.network
[Match]
Name=br0

[Network]
Address=192.168.100.101/24
EOF
    cat<<EOF>${TMPMNT}/etc/systemd/network/bridge.network
[Match]
Name=br0

[Network]
Address=192.168.100.100/24
EOF
}

