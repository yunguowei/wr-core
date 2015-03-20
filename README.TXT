# To build the intel-x86 BSP
. init-intel-x86-env
bitbake wrlinux-image-glibc-small


#----------------OR-------------------#

# To build the qemuarm BSP
. init-qemuarm-env
bitbake wrlinux-image-glibc-small
# Boot qemu
runqemu qemuarm nographic

