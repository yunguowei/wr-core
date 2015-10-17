Quick start instructions.

--- Intel Minnow Board BSP ---

git clone --branch beta --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core
. init-intel-x86-env
bitbake pod-domE pod-dom0 pod-essential

### login: root  password: incendia

#----------------OR-------------------#

--- Xilinx-Zynq BSP ---

git clone --branch beta --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core
. init-xilinx-zynq-env
bitbake pod-server pod-dom0 pod-essential

### login: root  password: incendia

