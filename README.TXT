Quick start instructions.

--- Intel Minnow Board BSP ---

git clone --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core
. init-intel-x86-env
bitbake wrlinux-image-glibc-small

# Test with KVM or boot on real hardware
kvm -hda tmp/deploy/images/intel-corei7-64/wrlinux-image-glibc-small-intel-corei7-64.hddimg

#----------------OR-------------------#

--- Qemu ARM BSP ---

git clone --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core
. init-qemuarm-env
bitbake wrlinux-image-glibc-small

# Test with qemuarm
runqemu qemuarm nographic

#----------------OR-------------------#

--- Qemu ARM BSP ---

git clone --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core
. init-qemuarm-env
bitbake wrlinux-image-glibc-small

# Test with your hardware following the README in xilinx-zynq/README
# in section 3.1 where the dtb files are found in:
# tmp/deploy/images/xilinx-zynq/uImage-zynq-*.dtb
