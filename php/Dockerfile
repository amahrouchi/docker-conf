FROM php:7.4-apache

RUN apt-get update --fix-missing && apt dist-upgrade

# PHP extensions
RUN docker-php-ext-install bcmath

# Xdebug
RUN pecl install xdebug-2.9.2
RUN docker-php-ext-enable xdebug

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
