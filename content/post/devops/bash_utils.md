---
title: "Bash Utils"
date: 2021-06-16T20:00:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "DevOps"
tags:
  - "Bash"
  - "Util"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---


## curl

### http code
```bash
url='https://test.juewei.com/actuator/health'; code=200; while [ $code -eq 200 ]; do code=`curl -I -m 30 -o /dev/null -s -w %{http_code}"\n" $url`; sleep 0.1; done
```


## 日志
分割日志文件
```bash
split -b 104857600 -d -a 6 nohup.out ./2021-07-12_
```
清空日志
```bash
sudo find . -name "*.log" -type f  | awk '{print "echo > "$0}' | bash
```

## MySQL备份
mysqldump是单线程备份,最蛋疼的是默认参数会锁表影响业务,其次参数顺序需要注意,不然默认不会生效.
1. 加入skip-opt防止锁表
2. 加入quick防止内存oom

```bash
mysqldump -h ${HOST} -u ${USER} -P 3306 -p${PASSWD}\$\@\$H --skip-opt --quick --default-character-set=utf8 --triggers ${DBNAME} | gzip > ./backup.gz
```


## git
### 批量删除远程tag
```bash
git show-ref --tag | awk '{print ":" $2}' | xargs git push origin
```
### 批量删除本地tag
```bash
git tag -l | xargs git tag -d
```
