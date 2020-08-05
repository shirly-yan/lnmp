FROM ubuntu:20.04
MAINTAINER shirly "yqzh186@163.com"

ENV DEBIAN_FRONTEND noninteractive

ADD ./ /config_file
WORKDIR /code

########nginx########
RUN set -x \
 && apt-get update \
 && apt-get install -y nginx vim curl git \
 && echo 'daemon off;' >> '/etc/nginx/nginx.conf' \
 && rm '/etc/nginx/sites-enabled/default' \
 && cp '/config_file/default.conf' '/etc/nginx/conf.d/default.conf'
########nginx########

#########php########
RUN set -x \
 && apt-get update \
 && apt-get install -yq --no-install-recommends php7.4 \
                                            php7.4-cli \
                                            php7.4-fpm \
                                            php7.4-json \
                                            php7.4-pdo \
                                            php7.4-mysql \
                                            php7.4-zip \
                                            php7.4-gd \
                                            php7.4-mbstring \
                                            php7.4-curl \
                                            php7.4-xml \
                                            php-pear \
                                            php7.4-bcmath
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
 && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
 && apt-get install -y nodejs
#########node########

#########redis########
RUN set -x \
 && apt-get update \
 && apt-get install -yq --no-install-recommends redis-server
#########redis########

#########crontab########
RUN set -x \
 && apt-get update \
 && apt-get install -yq --no-install-recommends cron
#########crontab########

EXPOSE 3306
EXPOSE 80
EXPOSE 443

CMD ["bash", "/config_file/deploy.sh"]








