---
title: "SSL/TLS"
date: 2021-09-18T16:21:00+08:00
lastmod: 2021-11-01T11:11:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "note"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
## 流程
[SSL/TLS流程](https://blog.csdn.net/ustccw/article/details/76691248)

## nginx证书和apache证书
apache和nginx的配置都是私钥key一个文件

apache是三个文件将中间链证书独立一个文件，而nginx是中间链证书和域名证书同一个文件

## 支付
1. PEM格式最好需要动保持原状包括换行符和插入不可见字符。经实际测试pem内容可以插入不可见字符如空格和tab符，但是行首必须是-----BEGIN和-----END
2. 支付宝小程序公钥方式是两套公钥, 将自己的公钥上传到支付宝平台对应的小程序的设置, 持有自己的私钥（应用私钥）和支付宝的公钥
3. 微信支付v2退款等某些操作需要证书才能，TLS双向通道签名+http body的sign签名
4. 微信支付v3退款等某些操作已经和支付宝一样使用了两对RSA
