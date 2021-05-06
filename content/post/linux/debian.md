---
title: "Linux Mirrors"
date: 2020-12-08T16:28:00+08:00
description: "Linux Mirrors"
categories:
  - "Linux"
tags:
  - "Debian"
  - "Ubuntu"
# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "Debian" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

## Debian Mirrors
将cloud.aliyuncs是阿里云ECS内部加速地址，换成aliyun就是互联网地址
### debian 10 buster
```bash 
echo > /etc/apt/sources.list
cat <<EOF | tee > /etc/apt/sources.list
## Note, this file is written by cloud-init on first boot of an instance
## modifications made here will not survive a re-bundle.
## if you wish to make changes you can:
## a.) add 'apt_preserve_sources_list: true' to /etc/cloud/cloud.cfg
##     or do the same in user-data
## b.) add sources in /etc/apt/sources.list.d
## c.) make changes to template file /etc/cloud/templates/sources.list.debian.tmpl
###

# See http://www.debian.org/releases/stable/i386/release-notes/ch-upgrading.html
# for how to upgrade to newer versions of the distribution.
deb http://mirrors.cloud.aliyuncs.com/debian/ buster main contrib non-free
deb http://mirrors.cloud.aliyuncs.com/debian/ buster-updates main contrib non-free
deb http://mirrors.cloud.aliyuncs.com/debian/ buster-proposed-updates main non-free contrib
deb http://mirrors.cloud.aliyuncs.com/debian/ buster-backports main non-free contrib
## Major bug fix updates produced after the final release of the
## distribution.
deb-src http://mirrors.cloud.aliyuncs.com/debian/ buster-updates main contrib non-free
deb-src http://mirrors.cloud.aliyuncs.com/debian/ buster main contrib non-free
deb-src http://mirrors.cloud.aliyuncs.com/debian/ buster-proposed-updates main contrib non-free
deb-src http://mirrors.cloud.aliyuncs.com/debian/ buster-backports main contrib non-free

deb http://mirrors.cloud.aliyuncs.com/debian-security/ buster/updates main non-free contrib
deb-src http://mirrors.cloud.aliyuncs.com/debian-security/ buster/updates main non-free contrib
## Uncomment the following two lines to add software from the 'backports'
## repository.
##
## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
EOF
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
```

### Ubuntu 20.04
```bash
echo > /etc/apt/sources.list
echo 'deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal main restricted universe multiverse' >> /etc/apt/sources.list
# deb-src https://mirrors.cloud.aliyuncs.com/ubuntu/ focal main restricted universe multiverse
echo 'deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-updates main restricted universe multiverse' >> /etc/apt/sources.list
# deb-src https://mirrors.cloud.aliyuncs.com/ubuntu/ focal-updates main restricted universe multiverse
echo 'deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list
# deb-src https://mirrors.cloud.aliyuncs.com/ubuntu/ focal-backports main restricted universe multiverse
echo 'deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-security main restricted universe multiverse' >> /etc/apt/sources.list
# deb-src https://mirrors.cloud.aliyuncs.com/ubuntu/ focal-security main restricted universe multiverse
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
apt-get install -y inetutils-ping
```
## Docker里安装sshd
> ["/bin/sh", "-c", "apt update && apt install -y openssh-server && sed -i 's/[# ]*UsePAM.*/UsePAM no/' /etc/ssh/sshd_config && sed -i 's/[# ]*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && service ssh restart && echo root:root | chpasswd"]
