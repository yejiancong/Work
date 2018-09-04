######
# See: https://hub.docker.com/_/php/
######

FROM php:7.1.10-fpm
MAINTAINER micooz <micooz@hotmail.com>

######
# You can install php extensions using docker-php-ext-install
######

COPY sources.list.aliyun /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
        cron \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libzip-dev \
        libcurl4-openssl-dev \
        git \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install bcmath

RUN pecl install zip \
    && docker-php-ext-enable zip \
#    && swoole \
#    && docker-php-ext-enable swoole \
#    && pecl install xdebug \
#    && docker-php-ext-enable xdebug \
    && pecl install redis-3.1.3 \
    && docker-php-ext-enable redis \
    && pecl install msgpack \
    && docker-php-ext-enable msgpack \
    && pecl install yar \
    && docker-php-ext-enable yar

# composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    mkdir -p /var/www/.composer && \
    chown www-data.www-data /var/www/.composer
USER www-data
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com
