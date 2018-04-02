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
	apache2 libapache2-mod-php7.1 \
	php7.1 php7.1-bz2 php7.1-cgi php7.1-cli php7.1-common php7.1-curl php7.1-dev \
	php7.1-mbstring php7.1-fpm php7.1-gd php7.1-gmp php7.1-imap php7.1-intl \
	php7.1-json php7.1-mcrypt php7.1-mysql php7.1-opcache \
	php7.1-phpdbg php7.1-recode php7.1-snmp php7.1-sybase \
	php7.1-tidy php7.1-xdebug php7.1-xmlrpc php7.1-xsl php7.1-zip

# Disable xdebug for cli
# RUN phpdismod -v 7.1 -s cli xdebug

# Install composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

# Install tools
RUN apt-get install -y vim git sendmail
RUN apt-get install -y icu-devtools icu-doc libicu-dev
RUN apt-get install -y iputils-ping

# Apache configuration
RUN rm /etc/apache2/sites-enabled/*
COPY ./vhosts/*.conf /etc/apache2/sites-available/
RUN a2ensite site.conf
RUN a2enmod rewrite
RUN a2enmod headers

# PHP configuration
COPY ./php/php.ini /etc/php/7.1/apache2
COPY ./php/php.ini /etc/php/7.1/cli

# Server name for CLI debugging (xDebug)
ENV PHP_IDE_CONFIG serverName=localhost

EXPOSE 80 22 443

# CMD ["/bin/bash"]
