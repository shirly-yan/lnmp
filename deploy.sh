#!/usr/bin/env bash

service mysql start

redis-server ./redis.conf

service php7.2-fpm start

echo 'daemon off;' >> '/etc/nginx/nginx.conf'
rm '/etc/nginx/sites-enabled/default'
cp './default.conf' '/etc/nginx/conf.d/default.conf'
service nginx start