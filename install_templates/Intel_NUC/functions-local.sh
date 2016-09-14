my_local_post_func()
{
	NETWORK_DEVICE="eth0"
	# Set the network prime device for network prime container by puppet on first boot
	sed -i "s/^\(\$network_prime_device *=\).*$/\1 \"${NETWORK_DEVICE}\"/" \
                 ${TMPMNT}/etc/puppet/manifests/site.pp
}

