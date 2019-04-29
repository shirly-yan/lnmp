#lnmp使用方法

拉取镜像
docker pull daocloud.io/shirly/lnmp:release_2

首次启动
docker run \
--publish 1080:80 --publish 1443:443 --publish 3333:3306 \
--name lnmp2 \
--restart always \
daocloud.io/shirly/lnmp:release_2

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
--volume /lnmp/msyql:/var/lib/mysql \
daocloud.io/shirly/lnmp:release_2

