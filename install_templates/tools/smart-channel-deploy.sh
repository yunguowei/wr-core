#!/bin/bash

while [ $# -gt 0 ]; do
    case "$1" in
    --config)
            CONFIG_FILE="$2"
            shift
            ;;
    --image)
            IMAGE="$2"
            shift
            ;;
         *) break
            ;;
    esac
    shift
done

usage(){

cat << EOF

smart-channel-deploy.sh --config <smart-config-file> --image <live image>

EOF
}

verify_root_user()
{
    if [ "$EUID" -ne 0 ]; then
        return 1
    fi
    return 0
}

if ! [ -e "$CONFIG_FILE" ]; then
	usage
	exit 1
else
	CONFIG_FILE=`readlink -f $CONFIG_FILE`
fi

if ! [ -e "$IMAGE" ]; then
        usage
	exit 1
else
	IMAGE=`readlink -f $IMAGE`
fi

verify_root_user
if [ $? != 0 ]; then
	echo "root right is required to run this script!"
	exit 1
fi

device=`losetup -f --show $IMAGE`
partprobe ${device}
if [ -z "$device" ]; then
	echo "[ERROR]: No free loop devices available"
	exit 1
fi

if ! [ -e "${device}p1" ]; then
        echo "[ERROR]: ${device}p1 cannot available!"
        losetup -d ${device}
        exit 1
fi

if ! [ -e "${device}p2" ]; then
	installer_sfr_image="Y"
elif ! [ -e "${device}p3" ]; then
	installer_image="Y"
else
	live_image="Y"
	if ! [ -e "${device}p4" ]; then
		echo "[ERROR]: ${device}p4 cannot available!"
		losetup -d ${device}
		exit 1
	fi
fi

function deploy_live(){
	device=$1
	dir=$2	

	mount ${device}p3 $dir
	if [ -e "$dir/rootfs/var/lib/lxc" ]; then
		mount ${device}p4 $dir/rootfs/var/lib/lxc
		cd $dir/rootfs
	elif [ -e "$dir/var/lib/lxc" ]; then
		mount ${device}p4 $dir/var/lib/lxc
		cd $dir
	else
		echo "[ERROR]: essential rootfs is not available"
		umount $dir
        	losetup -d ${device}
		exit 1
	fi

	if ! [ -d factory_tmp ]; then
		mkdir factory_tmp
	fi

	mount -o subvolid=5 ${device}p3 factory_tmp
	if [ -d factory_tmp/.factory/var/lib/lxc ]; then
		mount -o subvolid=5 ${device}p4 factory_tmp/.factory/var/lib/lxc
	fi

	echo "[INFO] deploy $CONFIG_FILE to essential"
	cp -f $CONFIG_FILE var/lib/smart/config

	if [ -d factory_tmp/.factory/var/lib/smart ]; then
		echo "[INFO] deploy $CONFIG_FILE to factory-reset backed essential"
		cp -f $CONFIG_FILE factory_tmp/.factory/var/lib/smart/config
	fi

	CN=`ls var/lib/lxc`

	for cn in $CN; do
		if [ -d var/lib/lxc/$cn/rootfs/var/lib/smart ]; then
			echo "[INFO] deploy $CONFIG_FILE to $cn"
			cp -f $CONFIG_FILE var/lib/lxc/$cn/rootfs/var/lib/smart/config

			if [ -d factory_tmp/.factory/var/lib/lxc/.factory/$cn/rootfs/var/lib/smart ]; then 
				echo "[INFO] deploy $CONFIG_FILE to factory-reset backed $cn"
				cp -f $CONFIG_FILE factory_tmp/.factory/var/lib/lxc/.factory/$cn/rootfs/var/lib/smart/config
			fi
		fi
	done

	echo "[INFO] clean up the system"
	umount factory_tmp/.factory/var/lib/lxc
	umount factory_tmp
	rm -rf factory_tmp
	umount var/lib/lxc
	cd - >/dev/null 2>&1
}

function deploy_installer(){
	device=$1
	dir=$2

	if [ "X$installer_sfr_image" == "XY" ]; then
		mount ${device}p1 $dir
	else
		mount ${device}p2 $dir
	fi

	cd $dir
	if [ -e "opt/installer/images" ]; then
		echo "[INFO] deploy $CONFIG_FILE to `pwd`/opt/installer/images/config.smart"
		cp -f $CONFIG_FILE opt/installer/images/config.smart
	elif [ -e "./sfr.dsk" ]; then
		echo "[INFO] deploy $CONFIG_FILE to `pwd`/sfr.dsk"
		mount ./sfr.dsk EFI
		cp -f $CONFIG_FILE EFI/installer/images/config.smart
		umount EFI
	fi
	
	cd - >/dev/null 2>&1
}

if ! [ -e "/z" ]; then
        mkdir /z
fi

if [ "X$installer_sfr_image" == "XY" -o "X$installer_image" == "XY" ]; then
	deploy_installer $device "/z"
elif [ "X$live_image" == "XY" ]; then
	deploy_live $device "/z"
fi

echo "umount directory /z"
umount "/z"
echo "release loop device $device"
losetup -d ${device}


