######
# See: https://hub.docker.com/_/php/
######

FROM php:7.3.3-fpm
MAINTAINER micooz <micooz@hotmail.com>

######
# You can install php extensions using docker-php-ext-install
######

#COPY sources.list.aliyun /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
        cron \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install opcache

RUN pecl install redis-4.2.0 \
    && docker-php-ext-enable redis

RUN pecl install swoole-4.3.1 \
    && docker-php-ext-enable swoole

# composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    mkdir -p /var/www/.composer && \
    chown www-data.www-data /var/www/.composer
USER www-data
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com
