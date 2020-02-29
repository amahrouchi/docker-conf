FROM httpd:2.4

COPY app-vhosts.conf /usr/local/apache2/conf/extra/
RUN echo "LoadModule deflate_module modules/mod_deflate.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule proxy_module modules/mod_proxy.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "Include /usr/local/apache2/conf/app-vhosts.conf" >> /usr/local/apache2/conf/httpd.conf

COPY httpd.conf /usr/local/apache2/conf/
#RUN a2enmod rewrite deflate proxy proxy_fcgi
