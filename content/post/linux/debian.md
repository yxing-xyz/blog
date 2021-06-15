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
```bash
sed -i 's#\w*\.debian\.org#mirrors\.163\.com#g' /etc/apt/sources.list
```
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
### Ubuntu 20.04
```bash
echo > /etc/apt/sources.list
cat <<EOF  | tee > /etc/apt/sources.list
## Note, this file is written by cloud-init on first boot of an instance
## modifications made here will not survive a re-bundle.
## if you wish to make changes you can:
## a.) add 'apt_preserve_sources_list: true' to /etc/cloud/cloud.cfg
##     or do the same in user-data
## b.) add sources in /etc/apt/sources.list.d
## c.) make changes to template file /etc/cloud/templates/sources.list.tmpl

# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# newer versions of the distribution.
deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal main restricted
deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ focal main restricted

## Major bug fix updates produced after the final release of the
## distribution.
deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-updates main restricted
deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-updates main restricted

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal universe
deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ focal universe
deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-updates universe
deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-updates universe

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal multiverse
deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ focal multiverse
deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-updates multiverse
deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-updates multiverse

## Uncomment the following two lines to add software from the 'backports'
## repository.
## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
deb http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ focal-backports main restricted universe multiverse

## Uncomment the following two lines to add software from Canonical's
## 'partner' repository.
## This software is not part of Ubuntu, but is offered by Canonical and the
## respective vendors as a service to Ubuntu users.
# deb http://archive.canonical.com/ubuntu focal partner
# deb-src http://archive.canonical.com/ubuntu focal partner

deb http://mirrors.cloud.aliyuncs.com/ubuntu focal-security main restricted
deb-src http://mirrors.cloud.aliyuncs.com/ubuntu focal-security main restricted
deb http://mirrors.cloud.aliyuncs.com/ubuntu focal-security universe
deb-src http://mirrors.cloud.aliyuncs.com/ubuntu focal-security universe
# deb http://mirrors.cloud.aliyuncs.com/ubuntu focal-security multiverse
# deb-src http://mirrors.cloud.aliyuncs.com/ubuntu focal-security multiverse
EOF
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
```
## Docker里安装sshd
> ["/bin/sh", "-c", "apt update && apt install -y openssh-server && sed -i 's/[# ]*UsePAM.*/UsePAM no/' /etc/ssh/sshd_config && sed -i 's/[# ]*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && service ssh restart && echo root:root | chpasswd"]
