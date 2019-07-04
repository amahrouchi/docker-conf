FROM ubuntu:16.04
MAINTAINER Angelo Mahrouchi

ARG DEBIAN_FRONTEND=noninteractive

# Init
RUN apt-get update && apt-get upgrade -y

# PHP 7 repo
RUN apt-get -y install python-software-properties software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update

# Install apache php 7
RUN apt-get install  -y --allow-unauthenticated \
	apache2 libapache2-mod-php7.2 \
	php7.2 php7.2-bz2 php7.2-cgi php7.2-cli php7.2-common php7.2-curl php7.2-dev \
	php7.2-mbstring php7.2-fpm php7.2-gd php7.2-gmp php7.2-imap php7.2-intl \
	php7.2-json php7.2-mysql php7.2-opcache \
	php7.2-phpdbg php7.2-recode php7.2-snmp php7.2-sybase \
	php7.2-tidy php7.2-xdebug php7.2-xmlrpc php7.2-xsl php7.2-zip

# Install Mcrypt through PECL (for PHP versions below 7.1 just install php7.x-mcrypt)
# RUN apt-get -y php7.1-mcrypt
RUN apt-get -y install gcc make autoconf libc-dev pkg-config
RUN apt-get -y install php7.2-dev
RUN apt-get -y install libmcrypt-dev
RUN pecl install mcrypt-1.0.1
RUN bash -c "echo extension=/usr/lib/php/20170718/mcrypt.so > /etc/php/7.2/cli/conf.d/mcrypt.ini"
RUN bash -c "echo extension=/usr/lib/php/20170718/mcrypt.so > /etc/php/7.2/apache2/conf.d/mcrypt.ini"

# Disable xdebug for cli
# RUN phpdismod -v 7.2 -s cli xdebug

# Install composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

# Install tools
RUN apt-get install -y vim git sendmail icu-devtools icu-doc libicu-dev iputils-ping

# Apache configuration
RUN rm /etc/apache2/sites-enabled/*
COPY ./vhosts/*.conf /etc/apache2/sites-available/
RUN a2ensite site.conf
RUN a2enmod rewrite headers ssl

# SSL
RUN mkdir /etc/apache2/ssl
COPY vhosts/ssl/* /etc/apache2/ssl/

# PHP configuration
COPY ./php/php.ini /etc/php/7.2/apache2
COPY ./php/php.ini /etc/php/7.2/cli

# Server name for CLI debugging (xDebug)
ENV PHP_IDE_CONFIG serverName=localhost

# Define the working directory
WORKDIR /var/www/app

# Ports to expose
EXPOSE 80 22 443

# CMD ["/bin/bash"]
