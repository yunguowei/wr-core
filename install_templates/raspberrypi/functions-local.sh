
my_local_post_func()
{

    # Add additional files to /boot
    df ${TMPMNT}/boot > /tmp/a.log
    df -k >> /tmp/a.log
    set >> /tmp/a.log
    cp $ARTIFACTS_DIR/bcm2835-bootfiles/* ${TMPMNT}/mnt
    for f in `ls $ARTIFACTS_DIR/Image-bcm*.dtb`; do
        cp $f ${TMPMNT}/mnt/${f##*Image-}
    done
    mkdir ${TMPMNT}/mnt/overlays
    for f in `ls $ARTIFACTS_DIR/*.dtbo |grep -v \+git` ; do
        cp $f ${TMPMNT}/mnt/overlays/${f##*/Image-}
    done
    # Rename kernel from bzImage -> kernel7.img
    rm -f ${TMPMNT}/mnt/bzImage_bakup
    mv ${TMPMNT}/mnt/bzImage ${TMPMNT}/mnt/kernel7.img

    # Remove initrd
    rm ${TMPMNT}/mnt/initrd

    # Setup cmdline.txt
    echo "dwc_otg.lpm_enable=0 console=ttyS0,115200 root=/dev/mmcblk0p3 rootfstype=btrfs rootwait pty.legacy_count=0" > ${TMPMNT}/mnt/cmdline.txt

    # Append to config.txt
    cat<<EOF>> ${TMPMNT}/mnt/config.txt
[pi1]
device_tree=bcm2708-rpi-b-plus.dtb
[pi2]
device_tree=bcm2709-rpi-2-b.dtb
[all]
dtparam=spi=on
dtparam=i2c1=on
dtparam=i2c_arm=on
enable_uart=1
dtoverlay=pitft28-resistive,rotate=90,speed=32000000,txbuflen=32768
EOF
    
}

