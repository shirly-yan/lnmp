FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

#########redis########
RUN set -x \
 && apt-get update \
 && apt-get install -yq --no-install-recommends redis-server
#########redis########

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

ADD ./ /laravel
WORKDIR /laravel

EXPOSE 3306
EXPOSE 80
EXPOSE 443

CMD ["bash", "deploy.sh"]








