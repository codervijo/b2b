#!/bin/bash
# DOESN"T WORK AS EXPECTED
echo "Hello from inside Lamill HAPROXY docker container"

if [ -e "/root/imgb4install" ]; then
	echo "First time run, installing wordpress for ${SITEURL}"


	echo "ENABLED=1">>/etc/default/haproxy
	rm -f /root/imgb4install
	echo "Completed Lamill HAPROXY installation"
	/bin/bash # XXX : hack to make run -d  wait forevah
fi

service haproxy start

exec "$@"
