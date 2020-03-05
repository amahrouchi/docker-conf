FROM httpd:2.4

# Install some tools
RUN apt-get update --fix-missing && apt dist-upgrade
RUN apt-get install -y software-properties-common vim git iputils-ping

# Let's Encrypt - Cerbot
RUN apt-get install -y certbot python-certbot-apache

# Apache configuration
COPY app-vhosts.conf /usr/local/apache2/conf/extra/
RUN echo "LoadModule deflate_module /usr/local/apache2/modules/mod_deflate.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule proxy_module /usr/local/apache2/modules/mod_proxy.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule rewrite_module /usr/local/apache2/modules/mod_rewrite.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule proxy_fcgi_module /usr/local/apache2/modules/mod_proxy_fcgi.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule headers_module /usr/local/apache2/modules/mod_headers.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule ssl_module /usr/local/apache2/modules/mod_ssl.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "Include /usr/local/apache2/conf/extra/app-vhosts.conf" >> /usr/local/apache2/conf/httpd.conf
