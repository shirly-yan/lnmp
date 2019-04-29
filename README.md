#lnmp使用方法

拉取镜像
docker pull daocloud.io/shirly/lnmp:release_3

首次启动
docker run \
--publish 1080:80 --publish 1443:443 --publish 3333:3306 \
--name lnmp2 \
--restart always \
daocloud.io/shirly/lnmp:release_3

创建文件夹
mkdir /lnmp
复制mysql初始文件到主机
docker cp lnmp2:/var/lib/mysql /lnmp/mysql

删除容器
docker stop lnmp2 && docker rm lnmp2

启动容器
docker run \
--publish 1080:80 --publish 1443:443 --publish 3333:3306 \
--name lnmp2 \
--restart always \
--volume /lnmp/code:/code \
--volume /lnmp/mysql:/var/lib/mysql \
daocloud.io/shirly/lnmp:release_3

进入容器内
docker exec -it lnmp2 bash

克隆项目
git clone https://shirly_yan:YQzh1861@git.coding.net/shirly_yan/robot.git /code

安装依赖
composer install

设置数据库信息
cp .env.example .env
vim .env

赋予权限
chown -R www-data:www-data /code

php artisan key:generate
php artisan migrate
php artisan db:seed
php artisan up

每次拉取
docker exec -it lnmp2 bash -c "cd /code && git pull"








