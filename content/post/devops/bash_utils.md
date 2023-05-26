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
## find
### 找可执行文件
```bash
find `pwd` -type f -executable -print
```

## grep
### 匹配字符串文件
```bash
grep -nr "r_secpolicy_t_ex" | grep -v  "匹配到" | grep -v ".o.d:" | awk -F '[/]' '{print $1}' | uniq
```

## curl
### http代理
```bash
curl -x 127.0.0.1:12333 baidu.com
```
### 双向认证
```bash
curl --cacert ./ca.crt  --key ./client.key --cert ./client.crt  https://127.0.0.1:443
```
### http code
```bash
url='https://test.juewei.com/actuator/health'; code=200; while [ $code -eq 200 ]; do code=`curl -I -m 30 -o /dev/null -s -w %{http_code}"\n" $url`; sleep 0.1; done
```
## openssl
### 查看https的证书信息
```bash
## 第一种方式
openssl s_client -servername prod.juewei.com -connect www.baidu.com:443  | openssl x509 -noout -dates
## 第二种
openssl s_client -connect {HOSTNAME}:{PORT} -showcerts
## 查看证书文件
gopenssl x509 -in ./blog.yxing.xyz.pem -noout -text
```

### openssl验证证书是否匹配CA根证书
只能一级级验证, 不能直接类似多级证书, 如nginx证书中间链和域名证书在一个文件中.需要手动拆分然后校验
```bash
openssl verify -CAfile ca_crt.pem ./server_cert.pem
```
### openssl验证证书是否匹配私钥
```bash
# 只输出writing RSA key表示匹配
diff -eq <(openssl x509 -pubkey -noout -in cert.pem) <(openssl rsa -pubout -in key.pem)
```

### openssl导出服务器证书
```bash
openssl s_client -showcerts -connect baidu.com:443
```
### 自签名x509 V1证书
```bash
# 1. 生成ca key
openssl genrsa -out ca_key.pem 2048
p# 2. 生成CA证书请求
openssl req -new -key ca_key.pem -out ca_csr.pem -subj "/C=CN/ST=Hunan Province/L=Yueyang/O=Yueyang Xing Company Limited/OU=/CN=Xing Root CA"
# 3. 生产CA证书
openssl x509 -req -days 3650 -in ca_csr.pem -signkey ca_key.pem -out ca_crt.pem
# 4. 生成新的服务器证书请求和key
openssl req -new -SHA256 -newkey rsa:2048 -nodes -keyout yxing.xyz.key -out yxing.xyz_csr.pem -subj "/C=CN/ST=Hunan Province/L=Yueyang/O=yxing.xyz/OU=/CN=dev.yxing.xyz"
# 5. CA签名客户端证书
openssl x509 -req -in yxing.xyz_csr.pem -out yxing.xyz_crt.pem -CA ca_crt.pem -CAkey ca_key.pem -CAcreateserial -days 360
```

### 签名


### 更换TLS证书
```bash
# 找特定的证书
grep -s baidu.com.crt ./*.conf
# 替换证书文件名
ls ./*.conf | xargs sed -i 's/a.crt/b.crt/' ./*.conf
# nginx检测下,然后重启
nginx -t
```

## redis
```bash
wget http://download.redis.io/releases/redis-6.0.1.tar.gz
tar xzf redis-6.0.1.tar.gz
cd redis-6.0.1
make BUILD_TLS=yes USE_SYSTEMD=yes -j4
make install
mkdir -p /etc/redis
cp ./redis.conf /etc/redis/
cp ./utils/systemd-redis_server.service  /etc/systemd/system/redis.service
# 编辑service指定配置文件启动
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

### 暂存文件部分内容修改
```bash
git add -p 历史已提交文件路径
```

### 只保留最新的提交记录
与`git clone --depth 1`类似, 如果操作当前分支会让当前分支停留在最新提交
```bash
git fetch --depth 1 origin master
```

## zsh
### 关闭zsh插件读取git信息导致卡吨
```bash
# 设置oh-my-zsh不读取文件变化信息
git config --add oh-my-zsh.hide-dirty 1
# 设置oh-my-zsh不读取任何git信息
git config --add oh-my-zsh.hide-status 1
```
## tmpfs加速
```bash
# 挂载
mount -t tmpfs -o size=4G tmpfs ./node_modules
# 拷贝到内存中
cp -RT ./.vscode/node_modules ./node_modules
yarn build
# 接触挂载
umount ./node_modules
```
