---
title: "Debian"
date: 2020-12-08T16:28:00+08:00
description: "Debian"
categories:
  - "Linux"
tags:
  - "Debian"
# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "Debian" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

## Debian常用包
将cloud.aliyuncs是阿里云ECS内部加速地址，换成aliyun就是互联网地址
### debian 10 buster
```bash 
echo > /etc/apt/sources.list
echo 'deb http://mirrors.cloud.aliyuncs.com/debian/ buster main non-free contrib' >> /etc/apt/sources.list
echo 'deb-src http://mirrors.cloud.aliyuncs.com/debian/ buster main non-free contrib' >> /etc/apt/sources.list
echo 'deb http://mirrors.cloud.aliyuncs.com/debian-security buster/updates main' >> /etc/apt/sources.list
echo 'deb-src http://mirrors.cloud.aliyuncs.com/debian-security buster/updates main' >> /etc/apt/sources.list
echo 'deb http://mirrors.cloud.aliyuncs.com/debian/ buster-updates main non-free contrib' >> /etc/apt/sources.list 
echo 'deb-src http://mirrors.cloud.aliyuncs.com/debian/ buster-updates main non-free contrib' >> /etc/apt/sources.list
echo 'deb http://mirrors.cloud.aliyuncs.com/debian/ buster-backports main non-free contrib' >> /etc/apt/sources.list 
echo 'deb-src http://mirrors.cloud.aliyuncs.com/debian/ buster-backports main non-free contrib' >> /etc/apt/sources.list

apt-get update -y &&
apt-get install -y procps &&
apt-get install -y htop &&
apt-get install -y apache2-utils  &&
apt-get install -y mtr-tiny &&
apt-get install -y net-tools &&
apt-get install -y dnsutils &&
apt-get install -y inetutils-ping
```
### debian 9 
```bash
echo > /etc/apt/sources.list
echo 'deb http://mirrors.cloud.aliyuncs.com/debian/ stretch main non-free contrib' >> /etc/apt/sources.list
echo 'deb-src http://mirrors.cloud.aliyuncs.com/debian/ stretch main non-free contrib' >> /etc/apt/sources.list
echo 'deb http://mirrors.cloud.aliyuncs.com/debian-security stretch/updates main' >> /etc/apt/sources.list
echo 'deb-src http://mirrors.cloud.aliyuncs.com/debian-security stretch/updates main' >> /etc/apt/sources.list
echo 'deb http://mirrors.cloud.aliyuncs.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list
echo 'deb-src http://mirrors.cloud.aliyuncs.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list
echo 'deb http://mirrors.cloud.aliyuncs.com/debian/ stretch-backports main non-free contrib' >> /etc/apt/sources.list
echo 'deb-src http://mirrors.cloud.aliyuncs.com/debian/ stretch-backports main non-free contrib' >> /etc/apt/sources.list


apt-get update -y &&
apt-get install -y procps &&
apt-get install -y htop &&
apt-get install -y apache2-utils  &&
apt-get install -y mtr-tiny &&
apt-get install -y net-tools &&
apt-get install -y dnsutils &&
apt-get install -y inetutils-ping

```

## Docker里安装sshd
> ["/bin/sh", "-c", "apt update && apt install -y openssh-server && sed -i 's/[# ]*UsePAM.*/UsePAM no/' /etc/ssh/sshd_config && sed -i 's/[# ]*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && service ssh restart && echo root:root | chpasswd"]
