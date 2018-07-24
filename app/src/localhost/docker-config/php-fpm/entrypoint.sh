#!/bin/sh

rm -rf /etc/default/locale
env >> /etc/default/locale

/usr/local/bin/docker-php-entrypoint php-fpm &
/usr/sbin/cron -f
