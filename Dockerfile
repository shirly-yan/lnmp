FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

########mysql########
RUN set -x \
 && apt-get update \
 && apt-get install -y --allow-unauthenticated mysql-server \
 && sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/mysql.conf.d/mysqld.cnf \
 && service mysql start \
 && mysqladmin -u root password root \
 && mysql -uroot -proot -e \
    "CREATE DATABASE project DEFAULT CHARACTER SET utf8; grant all privileges on project.* to project@'%' identified by 'project';"
#########mysql########

########nginx########
RUN set -x \
 && apt-get update \
 && apt-get install -y nginx vim curl git
########nginx########

#########php########
RUN set -x \
 && apt-get update \
 && apt-get install -yq --no-install-recommends php7.2-cli \
    libapache2-mod-php7.2 \
    php7.2-json \
    php7.2-curl \
    php7.2-fpm \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-soap \
    php7.2-sqlite3 \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    php-imagick \
    unzip
#########php########

#########composer########
RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer \
 && composer config -g repo.packagist composer https://packagist.phpcomposer.com
#########composer########

#########node########
RUN set -x \
 && curl -sL https://deb.nodesource.com/setup_8.x \
 && apt-get install -y nodejs
#########node########

#########redis########
RUN set -x \
 && apt-get update \
 && apt-get install -yq --no-install-recommends redis-server
#########redis########

ADD ./ /laravel
WORKDIR /laravel

EXPOSE 3306
EXPOSE 80
EXPOSE 443

CMD ["bash", "deploy.sh"]








