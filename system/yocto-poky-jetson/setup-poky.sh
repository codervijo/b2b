#!/bin/bash
export BRANCH="dunfell"
YOCTO_DIR=/src/
mkdir $YOCTO_DIR
if [ ! -d $YOCTO_DIR/"poky" ]; then
	cd $YOCTO_DIR; git clone git://git.yoctoproject.org/poky.git poky
	cd $YOCTO_DIR;  git clone -b ${BRANCH} https://github.com/OE4T/meta-tegra.git
fi
ls -l 
ls -l poky
export LC_ALL="en_US.UTF-8"
(cd poky && git submodule update --init)
cat << EOFHERE >> $YOCTO_DIR/build/conf/bblayers.con
 BBLAYERS ?= " \
  /home/${USER}/yocto-tegra/meta-tegra \
  /home/${USER}/yocto-tegra/poky/meta \
  /home/${USER}/yocto-tegra/poky/meta-poky \
  /home/${USER}/yocto-tegra/poky/meta-yocto-bsp \
  "
EOFHERE
(cd $YOCTO_DIR/poky && source oe-init-build-env build && bitbake core-image-sato-dev)
