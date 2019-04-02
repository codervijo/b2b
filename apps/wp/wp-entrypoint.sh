#!/bin/bash
echo "Hello from inside docker container"

if [ -e "/root/imgb4install" ]; then
	echo "First time run, installing wordpress"
	service mysql start
	mysqladmin password 'root'
	mysql -u root --password='root' -e "CREATE USER 'wpuser' IDENTIFIED BY 'userpassword';"
	mysql -u root --password='root' -e "CREATE DATABASE wp_database;"
	mysql -u root --password='root' -e "GRANT ALL ON 'wp_database'.* TO 'wpuser';"
	mysql -u root --password='root' -e "FLUSH PRIVILEGES"

    service apache2 restart
	rm /root/imgb4install
fi
/bin/bash
