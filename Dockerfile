FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

########nginx########
RUN set -x \
 && apt-get update \
 && apt-get install -y nginx vim curl
########nginx########

#########redis########
RUN set -x \
 && apt-get update \
 && apt-get install -yq --no-install-recommends redis-server
#########redis########

########mysql########
RUN set -x \
 && apt-get update \
 && apt-get install -y --allow-unauthenticated mysql-server \
 && sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/mysql.conf.d/mysqld.cnf
#########mysql########

ADD ./ /laravel
WORKDIR /laravel

EXPOSE 3306
EXPOSE 80
EXPOSE 443

CMD ["bash", "deploy.sh"]








