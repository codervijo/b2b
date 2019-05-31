#!/bin/bash
echo "Hello from inside Lamill SLB docker container"

if [ -e "/root/imgb4install" ]; then
	echo "First time run"

	rm -f /root/imgb4install
	echo "Completed Lamill SLB installation"
fi

rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
service nginx start

exec "$@"
