#!/usr/bin/env bash

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
service mysql start

redis-server /config_file/redis.conf

service php7.2-fpm start

service nginx start