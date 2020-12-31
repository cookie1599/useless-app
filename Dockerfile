FROM php:7.2.2-fpm


LABEL name="actions-runner-docker"
LABEL maintenance="cookie1599"

#install another tools 
RUN apt-get update && apt-get install -y libmcrypt-dev \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
&& docker-php-ext-install mcrypt mariadb/server:10.4 utils

#if you want to install composer 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


#directory for project
WORKDIR /app
COPY . /app

#run with composer 
RUN composer install

CMD php artisan serve --host=0.0.0.0 --port=8000
EXPOSE 8000