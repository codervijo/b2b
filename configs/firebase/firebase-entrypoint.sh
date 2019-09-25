#!/bin/bash
echo "Hello from inside Lamill Firebase Go docker container"
echo "Invoke firebase as follows for login to google:"
echo "sudo docker run -p 9005:9005 -it fbase4  firebase login"
echo "Note a problem : cannot run multiple commands inside docker"

if [ -e "/root/imgb4install" ]; then
	echo "First time run"

	rm -f /root/imgb4install
	echo "Completed Lamill Firebase Go installation"
fi

firebase login
exec "$@"
