FROM php:7.4-fpm

RUN apt-get update --fix-missing && apt dist-upgrade

# PHP extensions
RUN docker-php-ext-install bcmath

# Xdebug
RUN pecl install xdebug-2.9.2
RUN docker-php-ext-enable xdebug
COPY ini/xdebug.ini /usr/local/etc/php/conf.d/

# Enable php.ini file
RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
#RUN mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
