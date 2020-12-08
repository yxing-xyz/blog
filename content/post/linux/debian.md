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

apt-get install -y htop
apt-get install -y apache2-utils 
apt-get install -y mtr-tiny 
apt-get install -y net-tools 
apt-get install -y dnsutils 
apt-get install -y inetutils-ping

```

