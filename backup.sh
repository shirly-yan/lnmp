#!/bin/bash
/usr/bin/mysqldump -uproject -pproject project | gzip > /root/backup/project_$(date +%Y%m%d_%H%M%S).sql.gz