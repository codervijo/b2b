#!/bin/bash
echo "Hello from inside Lamill Firebase Go docker container"

if [ -e "/root/imgb4install" ]; then
	echo "First time run"

	rm -f /root/imgb4install
	echo "Completed Lamill Firebase Go installation"
fi

exec "$@"
