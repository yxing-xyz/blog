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
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
## 同步时间
```bash
sudo ntpdate ntp.aliyun.com
sudo hwclock -w
```

## curl

### http code
```bash
url='https://test.juewei.com/actuator/health'; code=200; while [ $code -eq 200 ]; do code=`curl -I -m 30 -o /dev/null -s -w %{http_code}"\n" $url`; sleep 0.1; done
```
## openssl
### 查看https的证书信息
```bash
openssl s_client -servername prod.juewei.com -connect www.baidu.com:443  | openssl x509 -noout -dates
```

### 更换TLS证书
```bash
# 找特定的证书
grep -s baidu.com.crt ./*.conf
# 替换证书文件名
ls ./*.conf | xargs sed -i 's/a.crt/b.crt/' ./*.conf
# nginx检测下,然后重启
nginx -t
```

## 日志
分割日志文件
```bash
split -b 104857600 -d -a 6 nohup.out ./2021-07-12_
```
清空日志
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


## git
### 批量删除远程tag
```bash
git show-ref --tag | awk '{print ":" $2}' | xargs git push origin
```
### 批量删除本地tag
```bash
git tag -l | xargs git tag -d
```
