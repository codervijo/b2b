#!/bin/bash
echo "Hello from inside Lamill Go 1.8 docker container"

if [ -e "/root/imgb4install" ]; then
	echo "First time run"

	rm -f /root/imgb4install
	echo "Completed Lamill Go 1.8 installation"
fi

exec "$@"
