FROM debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN apt-get update -qq && apt-get install -y apache2 mysql-server php
RUN apt-get install -y git vim net-tools ssh wget
RUN apt-get install -y php-curl php-gd php-mbstring php-xml php-xmlrpc
RUN apt-get install -y php-soap php-intl php-zip php7.0-mysql
RUN apt-get install -y bash less mysql-client

RUN mkdir /usr/src/app
RUN mkdir -p /root/pkgs

WORKDIR /usr/src/app

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
#RUN { \
#		echo 'opcache.memory_consumption=128'; \
#		echo 'opcache.interned_strings_buffer=8'; \
#		echo 'opcache.max_accelerated_files=4000'; \
#		echo 'opcache.revalidate_freq=2'; \
#		echo 'opcache.fast_shutdown=1'; \
#		echo 'opcache.enable_cli=1'; \
#	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# https://codex.wordpress.org/Editing_wp-config.php#Configure_Error_Logging
#RUN { \
#		echo 'error_reporting = 4339'; \
#		echo 'display_errors = Off'; \
#		echo 'display_startup_errors = Off'; \
#		echo 'log_errors = On'; \
#		echo 'error_log = /dev/stderr'; \
#		echo 'log_errors_max_len = 1024'; \
#		echo 'ignore_repeated_errors = On'; \
#		echo 'ignore_repeated_source = Off'; \
#		echo 'html_errors = Off'; \
#	} > /usr/local/etc/php/conf.d/error-logging.ini

RUN (cd /root/pkgs ; \
     wget  "https://wordpress.org/wordpress-latest.tar.gz"; \
     tar zxvf wordpress-latest.tar.gz; \
     mkdir -p /var/www/html/blog; \
     mv wordpress/* /var/www/html/blog/; \
     rm /var/www/html/index.html; \
     chown -R www-data:www-data /var/www/html)

# Now install wp cli
RUN (cd /root/pkgs; \
     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
     chmod +x wp-cli.phar; \
     mv wp-cli.phar /usr/local/bin/wp; \
     wp --info)

ARG  SITEURL=lamill.io
ENV  SITEURL=${SITEURL}
RUN  touch /root/imgb4install
COPY wp-entrypoint.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/wp-entrypoint.sh"]
