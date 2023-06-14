---
title: "Openssl"
date: 2023-06-12T16:52:00+08:00
lastmod: 2023-06-12T16:52:00+08:00
draft: false
categories:
  - "命令行"
tags:
  - "命令行"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 查看Https的证书信息
2. 验证证书是否匹配CA证书
3. 验证证书是否匹配私钥
4. 连接host地址导出证书
5. 自签名x509 V1证书
<!--more-->

## openssl
### 查看https的证书信息
```bash
## 第1种, 查看TLS端口证书
openssl s_client -connect {HOSTNAME}:{PORT} -showcerts
## 第2种, 查看证书文件
openssl x509 -in ./blog.yxing.xyz.pem -noout -text
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
### 连接host地址导出证书
```bash
openssl s_client -showcerts -connect baidu.com:443
```
### 自签名x509 V1证书
```bash
# 1. 生成ca key
openssl genrsa -out ca_key.pem 2048
# 2. 生成CA证书请求
openssl req -new -key ca_key.pem -out ca_csr.pem -subj "/C=CN/ST=Hunan Province/L=Yueyang/O=Yueyang Xing Company Limited/OU=/CN=Xing Root CA"
# 3. 生产CA证书
openssl x509 -req -days 3650 -in ca_csr.pem -signkey ca_key.pem -out ca_crt.pem
# 4. 生成新的服务器证书请求和key
openssl req -new -SHA256 -newkey rsa:2048 -nodes -keyout yxing.xyz.key -out yxing.xyz_csr.pem -subj "/C=CN/ST=Hunan Province/L=Yueyang/O=yxing.xyz/OU=/CN=dev.yxing.xyz"
# 5. CA签名客户端证书
openssl x509 -req -in yxing.xyz_csr.pem -out yxing.xyz_crt.pem -CA ca_crt.pem -CAkey ca_key.pem -CAcreateserial -days 360
```
