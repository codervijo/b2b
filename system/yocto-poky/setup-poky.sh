#!/bin/bash
if [ ! -d "poky" ]; then
	git clone https://git.yoctoproject.org/poky -b kirkstone
fi
ls -l 
ls -l poky
export LC_ALL="en_US.UTF-8"
(cd poky && source oe-init-build-env build && bitbake core-image-minimal)
