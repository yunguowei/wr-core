
my_local_post_func()
{
    # cube-gw configuration
    perl -p -i -e 's#^lxc.network.*##' ${TMPMNT}/var/lib/lxc/cube-gw/config
    echo "lxc.console = /dev/ttyS0" >> ${TMPMNT}/var/lib/lxc/cube-gw/config
    echo "lxc.network.type = none" >> ${TMPMNT}/var/lib/lxc/cube-gw/config
    ln -sf /dev/null ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/getty.target.wants/serial-getty@ttyS0.service
    rm -f ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/multi-user.target.wants/named.service
    ln -sf /dev/null ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/named.service
    rm -f ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/multi-user.target.wants/systemd-networkd.service
    ln -sf /dev/null ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/systemd-networkd.service
    rm -f ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/systemd-resolved.service
    ln -sf /dev/null ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/systemd-resolved.service
    cat<<EOF>${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/config/network
config interface 'loopback'
	option ifname 'lo'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'

config interface 'wan'
	option ifname 'eth0'
	option proto 'dhcp'

config interface 'lan'
	option ifname 'eth2 vethdom0 wlan0'
	option type 'bridge'
	option proto 'static'
	option ipaddr '192.168.10.1'
	option netmask '255.255.255.0'

config device 'modem_cell'
	option name 'modem_cell'
	option present 'No'

config device 'sim_card'
	option name 'sim_card'
	option present 'No'

EOF
    cat<<EOF>>${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/config/dhcp

config host
	option name 'cube-dom0'
	option mac '00:00:00:01:01:01'
	option ip '192.168.10.111'
EOF
    # essential configuration
    perl -p -i -e 's#cube-server#cube-gw#' ${TMPMNT}/etc/cube-cmd-server.conf
    rm -f ${TMPMNT}/etc/systemd/system/multi-user.target.wants/named.service
    ln -sf /dev/null ${TMPMNT}/etc/systemd/system/named.service
    rm -f ${TMPMNT}/etc/systemd/system/multi-user.target.wants/systemd-networkd.service
    ln -sf /dev/null ${TMPMNT}/etc/systemd/system/systemd-networkd.service
    # dom0 configuration
    perl -p -i -e 's#^lxc.network.*##' ${TMPMNT}/var/lib/lxc/dom0/config
    echo "lxc.network.type = veth" >> ${TMPMNT}/var/lib/lxc/dom0/config
    echo "lxc.network.name = eth0" >> ${TMPMNT}/var/lib/lxc/dom0/config
    echo "lxc.network.veth.pair = vethdom0" >> ${TMPMNT}/var/lib/lxc/dom0/config
    echo "lxc.network.type = none" >> ${TMPMNT}/var/lib/lxc/cube-gw/config
    perl -p -i -e 's#cube-server#cube-gw#' ${TMPMNT}/var/lib/lxc/dom0/rootfs/etc/cube-cmd-server.conf
    rm ${TMPMNT}/var/lib/lxc/dom0/rootfs/etc/systemd/network/*
    cat<<EOF>${TMPMNT}/var/lib/lxc/dom0/rootfs/etc/systemd/network/wired.network
[Match]
Name=eth0

[Network]
Address=192.168.10.111/24
Gateway=192.168.10.1
EOF
}

