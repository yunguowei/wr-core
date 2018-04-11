Quick start instructions to build Wind River Pulsar Linux
for the NXP i.MX 6SoloX board.

For a more guides, examples and information please see:
https://knowledge.windriver.com/?cid=pulsar_lx

For official images please visit:
http://pulsar.windriver.com

############## Quick start clip here ###################
git clone -b pulsar-lts-17 --recurse-submodules https://github.com/WindRiver-OpenSourceLabs/wr-core
cd wr-core

######### The first time only, check for required host packages #########
./scripts/host_package_install.sh --install --yes
#########################################################################

Init the environment
$. init-nxp-imx6-env

Build the images
$bitbake cube-gw-ostree-runtime

Once build successfully, you can locate the image from:
<build dir>/tmp/deploy/images/nxp-imx6/ube-gw-ostree-runtime-nxp-imx6.wic

Then dd it to an usb stick or sd card and boot up Pulsar directly on target

### login: root  password: incendia

###### Publishing The Pulsar system's OStree Repository ######

Pulsar system is managed by OStree repositories. If you had some changes to the wr-core source
codes and wanted to apply these changes to your system which had been deploy on the target, please
use or create a new project and then then build the image cube-gw-ostree-runtime, once it was built
successfully, it will produce an OStree repository and a http configure file which help you deploy this
OStree repository easily.  If you run apache on your machine, you simply need to drop this configure file
to /etc/apache2/sites-enabled/ and restart apache. For my distro of choice this can be accomplished with 
the following commands:

$sudo cp <project dir>/tmp/deploy/images/nxp-imx6/cube-gw-ostree-runtime-nxp-imx6.rootfs.ostree.http.conf /etc/apache2/sites-enabled/
$sudo apachectl restart

Next we need to let your Pulsar system on our machine know about the repository. This can be done with the following command. 
If you're unsure about the correct URI and filesystem paths, take peak inside the generate http.conf file.

#ostree remote add pulsar-linux http://<your build host IP>/pulsar-linux/nxp-imx6 --no-gpg-verify
#ostree admin set-origin pulsar-linux http://<your build host IP>/pulsar-linux/nxp-imx6

Then you can use the following command to update/upgrade your system now:

#ostree admin upgrade 

Once the update/upgrade completed, you need to reboot your system to apply the changes.

###### To Setup a development environment on Pulsar system ######

Pulsar is based on the OStree system, thus its rootfs is readonly and you cannot do any changes
to the system's "/usr", "/bin" and "/lib" etc key system components. If you want to add/install 
any other packages by rpm/dnf command, you should unlock the ostree first. There are two types of
unlocks: "unlock temporarily" and "unlock with hotfix". The difference between them is that: "unlock
temporarily" will not keep the changes after the system reboots; On the contrary, "unlock with hotfix"
will retain changes across reboots. 

To do the "unlock temporarily", please run command:
#ostree admin unlock

To do the "unlock with hotfix", please run command:
#ostree admin unlock --hotfix

Once you do the unlock, you can install any programs in the system by rpm/dnf commands.

