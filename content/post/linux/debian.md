---
title: "Debian"
date: 2020-12-08T16:28:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Debian"
  - "Ubuntu"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## Debian Mirrors
将cloud.aliyuncs是阿里云ECS内部加速地址，换成aliyun就是互联网地址
```bash
sed -i 's#\w*\.debian\.org#mirrors\.tencent\.com#g' /etc/apt/sources.list
```
## 常用包
```bash
apt-get update -y &&
apt-get install -y procps &&
apt-get install -y htop &&
apt-get install -y apache2-utils  &&
apt-get install -y mtr-tiny &&
apt-get install -y net-tools &&
apt-get install -y dnsutils &&
apt-get install -y inetutils-ping &&
apt-get install -y nfs-kernel-server &&
apt-get install -y less &&
apt-get install -y iproute2 &&
apt-get install -y bridge-utils
## 18.04
apt-get install -y libfreetype6-dev
```

## Docker里安装sshd
```Dockerfile
["/bin/sh", "-c", "apt update && apt install -y openssh-server && sed -i 's/[# ]*UsePAM.*/UsePAM no/' /etc/ssh/sshd_config && sed -i 's/[# ]*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && && service ssh restart && echo root:root | chpasswd"]
```
