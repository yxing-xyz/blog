---
title: "Curl"
date: 2021-06-01T16:52:00+08:00
lastmod: 2023-06-12T16:52:00+08:00
draft: false
categories:
  - "命令行"
tags:
  - "命令行"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 请求设置http代理
2. 请求双向证书认证
<!--more-->
## curl
### http代理
```bash
curl -x 127.0.0.1:12333 baidu.com
```
### 双向认证
```bash
curl --cacert ./ca.crt  --key ./client.key --cert ./client.crt  https://127.0.0.1:443
```
