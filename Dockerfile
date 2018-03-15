FROM ubuntu

# Packages installation
RUN apt-get update && apt-get install -y \
		git curl unzip \
		nginx \
		php7.0-fpm \
		php-cli \
		php-mysql \
		supervisor
RUN mkdir -p /run/php
RUN	curl https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer

# Cleaning
RUN rm -rf /etc/nginx/sites-enabled/* && \
    rm -rf /var/www/*

# Configurations files
ADD conf/default.conf /etc/nginx/sites-enabled/default.conf
ADD conf/supervisord.conf /etc/supervisord.conf
ADD www/index.php /var/www/html/index.php

# Nginx logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]
