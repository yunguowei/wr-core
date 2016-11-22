
my_local_post_func()
{
    # cube-gw configuration
    rm -f ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/multi-user.target.wants/named.service
    ln -sf /dev/null ${TMPMNT}/var/lib/lxc/cube-gw/rootfs/etc/systemd/system/named.service
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
        option ifname 'wlan0 eth1'
        option type 'bridge'
        option proto 'static'
        option ipaddr '192.168.10.1'
        option netmask '255.255.255.0'

config interface 'wwan'
        option ifname '3g-wwan'
        option proto '3g'
        option device '/dev/ttyACM0'
        option ppp_redial 'demand'
        option defaultroute '1'
        option peerdns '1'
        option service 'umts_first'
        option dialnumber '*99***1#'

config device 'modem_cell'
        option name 'modem_cell'
        option present 'No'

config device 'sim_card'
        option name 'sim_card'
        option present 'No'
EOF

    # essential configuration
    perl -p -i -e 's#cube-server#cube-gw#' ${TMPMNT}/etc/cube-cmd-server.conf
    rm -f ${TMPMNT}/etc/systemd/system/multi-user.target.wants/named.service
    ln -sf /dev/null ${TMPMNT}/etc/systemd/system/named.service
    # dom0 configuration
    perl -p -i -e 's#cube-server#cube-gw#' ${TMPMNT}/var/lib/lxc/dom0/rootfs/etc/cube-cmd-server.conf
    #config essential's dnsmasq service
    rm -rf ${TMPMNT}/lib/systemd/system/dnsmasq.service
    cat<<EOF>${TMPMNT}/lib/systemd/system/dnsmasq.service
[Unit]
Description=DNS forwarder and DHCP server
After=network.target

[Service]
Type=forking
PIDFile=/run/dnsmasq.pid
ExecStart=/usr/bin/dnsmasq -x /run/dnsmasq.pid
ExecReload=/bin/kill -HUP \$(/bin/cat /run/dnsmasq.pid)

[Install]
WantedBy=multi-user.target
EOF
}

