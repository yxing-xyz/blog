---
title: "运维基础"
date: 2021-09-28T16:52:00+08:00
lastmod: 2021-09-28T16:52:00+08:00
draft: false
categories:
  - "DevOps"
tags:
  - "DevOps"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
## 日志
### 分割日志文件
```bash
split -b 104857600 -d -a 6 nohup.out ./2021-07-12_
```
#### 清空日志
```bash
sudo find . -name "*.log" -type f -size 1M | awk '{print "echo > "$0}' | bash
sudo find . -name "*.log" -type f -size 1M | xargs truncate -s 0
```
## MySQL备份
mysqldump是单线程备份,最蛋疼的是默认参数会锁表影响业务,其次参数顺序需要注意,不然默认不会生效.
1. 加入skip-opt防止锁表
2. 加入quick防止内存oom

```bash
mysqldump -h ${HOST} -u ${USER} -P 3306 -p${PASSWD}\$\@\$H --skip-opt --quick --default-character-set=utf8 --triggers ${DBNAME} | gzip > ./backup.gz
```