FROM php:8.0-fpm

RUN apt-get update --fix-missing && apt dist-upgrade -y

# Install some tools
RUN apt-get install -y software-properties-common vim git iputils-ping zip libzip-dev unzip

# PHP extensions
RUN docker-php-ext-install bcmath pdo pdo_mysql zip

# Xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
COPY ini/xdebug.ini /usr/local/etc/php/conf.d/

# Enable php.ini file
#RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

