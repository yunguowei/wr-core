## Quick start instructions to build Wind River Pulsar Linux ##

# For a more guides, examples and information please see:
#      https://knowledge.windriver.com/?cid=pulsar_lx



bitbake cube-dom0 cube-server cube-essential

sudo ../overc-installer/sbin/cubeit --force \
   --config `pwd`/../install_templates/arm/qemuarma9-live.sh \
   --target-config qemuarma9-live.sh \
   --artifacts `pwd`/tmp/deploy/images/qemuarma9 pulsar7-qemuarma9.img

# Simulate the image:

./tmp/sysroots/x86_64-linux/usr/bin/qemu-system-arm \
  -nographic \
  -kernel tmp/deploy/images/qemuarma9/zImage \
  -net user,hostfwd=tcp::4440-10.0.2.15:22,hostfwd=tcp::4441-10.0.2.16:22,hostfwd=tcp::4442-10.0.2.17:22 \
  -net nic \
  -m 1024 \
  -M vexpress-a9 \
  -append "console=ttyAMA0,115200 root=/dev/mmcblk0p3 rootwait ro" \
  -sd pulsar7-qemuarma9.img
