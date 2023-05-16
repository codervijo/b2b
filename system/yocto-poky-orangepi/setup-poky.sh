#!/bin/bash
if [ ! -d "orange-pi-distro" ]; then
	git clone https://github.com/Halolo/orange-pi-distro
fi
ls -l 
ls -l orange-pi-distro
export LC_ALL="en_US.UTF-8"
(cd orange-pi-distro && git submodule update --init)
(cd orange-pi-distro && . source-me orange-pi-zero && bitbake opiz-minimal)
#(cd poky && source oe-init-build-env build && bitbake core-image-minimal)
