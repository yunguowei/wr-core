Quick start instructions to build Wind River Pulsar Linux
for the Intel Minnow Board Max and Intel Compute Stick
(Cherry Trail and Bay Trail)

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
$. init-intel-x86-env

Build the images
$bitbake cube-gw-ostree-runtime

Then dd it to an usb stick or sd card and boot up Pulsar directly on target

### login: root  password: incendia

If you want to deploy Pulsar to your target local storage, such as sda, please
run the following comnand after the system had boot up successfully:

#installer create /var/wic.wks.sample

<Notes: This command will format your sda device and deploy the Pulsar system onto it>

###### Publishing The Pulsar system's OStree Repository ######
Pulsar system is managed by OStree repositories. If you had some changes to the wr-core source
codes and wanted to apply these changes to your system which had been deploy on the target, please
use or create a new project and then then build the image cube-gw-ostree-runtime, once it was built
successfully, it will produce an OStree repository and a http configure file which help you deploy this
OStree repository easily.  If you run apache on your machine, you simply need to drop this configure file
to /etc/apache2/sites-enabled/ and restart apache. For my distro of choice this can be accomplished with 
the following commands:

$sudo cp <project dir>/tmp/deploy/images/intel-corei7-64/cube-gw-ostree-runtime-intel-corei7-64.rootfs.ostree.http.conf /etc/apache2/sites-enabled/
$sudo apachectl restart

Next we need to let your Pulsar system on our machine know about the repository. This can be done with the following command. 
If you're unsure about the correct URI and filesystem paths, take peak inside the generate http.conf file.

#ostree remote add pulsar-linux http://<your build host IP>/pulsar-linux/intel-corei7-64 --no-gpg-verify
#ostree admin set-origin pulsar-linux http://<your build host IP>/pulsar-linux/intel-corei7-64

Then you can use the following command to update/upgrade your system now:

#ostree admin upgrade 

Once the update/upgrade completed, you need to reboot your system to apply the it.

