FROM php:7.3-apache

ADD web/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update && \
    apt-get install -y zlib1g-dev libicu-dev g++ libxml2-dev libzip-dev zip unzip curl git

RUN pecl install xdebug-2.9.2 && docker-php-ext-enable xdebug

RUN docker-php-ext-configure intl && \
    docker-php-ext-install intl bcmath zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

RUN a2enmod rewrite && service apache2 restart

COPY . /var/www/html
RUN cd /var/www/html && composer install

RUN chown -R www-data:www-data /var/www/html
