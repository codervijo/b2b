#!/bin/bash
echo "Hello from inside Lamill Wordpress-Dev docker container"

DBNAME="wpdb"
DBUSER="wpuser"
DBPASS="userpasswd"
SITEADMIN="admin"
ADMINPASS="admin123"

if [ -e "/root/imgb4install" ]; then
	echo "First time run, installing wordpress for ${SITEURL}"
	service mysql start
	mysqladmin password 'root'
	mysql -u root --password='root' -e "CREATE USER '${DBUSER}' IDENTIFIED BY '${DBPASS}';"
	mysql -u root --password='root' -e "CREATE DATABASE ${DBNAME};"
	mysql -u root --password='root' -e "GRANT ALL ON ${DBNAME}.* TO '${DBUSER}';"
	mysql -u root --password='root' -e "FLUSH PRIVILEGES"

    #cp /etc/apache2/sites-available/default /etc/apache2/sites-available/${SITEURL}

	(cd /var/www/html/ && /usr/local/bin/wp core config   --allow-root --dbname=${DBNAME} --dbuser=${DBUSER} --dbpass=${DBPASS})
	(cd /var/www/html/ && /usr/local/bin/wp core install  --allow-root --url=${SITEURL} --title="Lamill Websystems Dev Env" --admin_user=${SITEADMIN} --admin_password=${ADMINPASS} --admin_email=vik@lamill.us)

    a2ensite ${SITEURL}

	a2enmod rewrite
    service apache2 restart
	rm -f /root/imgb4install
	echo "Completed Lamill Wordpress-Dev installation"
	/bin/bash # XXX : hack to make run -d  wait forevah
fi

exec "$@"
