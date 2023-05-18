FROM wordpress:php7.4-apache

RUN a2enmod ssl && a2enmod rewrite
RUN mkdir -p /etc/apache2/ssl
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY ./ssl/*.pem /etc/apache2/ssl/
COPY ./apache/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY xdebug.ini "${PHP_INI_DIR}/conf.d"
RUN pecl install xdebug-2.9.0
RUN docker-php-ext-enable xdebug

EXPOSE 80
EXPOSE 443

