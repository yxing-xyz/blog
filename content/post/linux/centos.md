---
title: "Centos"
date: 2017-07-09T17:32:04+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Centos"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## Centos 7换源
```bash
sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.ustc.edu.cn/centos|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-Base.repo
```
## Centos 8 Stream换源
```bash
sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/$contentdir/$releasever|baseurl=https://mirrors.ustc.edu.cn/centos/8-stream/|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-Linux-AppStream.repo \
         /etc/yum.repos.d/CentOS-Linux-BaseOS.repo \
         /etc/yum.repos.d/CentOS-Linux-Extras.repo \
         /etc/yum.repos.d/CentOS-Linux-PowerTools.repo

# sed -i 's#^mirrorlist=.*infra=$infra#\#&#g' /etc/yum.repos.d/CentOS-Linux-AppStream.repo
# echo 'baseurl=https://mirrors.aliyun.com/$contentdir/$releasever/AppStream/$basearch/os/' >> /etc/yum.repos.d/CentOS-Linux-AppStream.repo

# sed -i 's#^mirrorlist=.*infra=$infra#\#&#g' /etc/yum.repos.d/CentOS-Linux-BaseOS.repo
# echo 'baseurl=https://mirrors.aliyun.com/$contentdir/$releasever/BaseOS/$basearch/os/' >> /etc/yum.repos.d/CentOS-Linux-BaseOS.repo
# sed -i 's#^mirrorlist=.*infra=$infra#\#&#g' /etc/yum.repos.d/CentOS-Linux-Extras.repo
# echo 'baseurl=https://mirrors.aliyun.com/$contentdir/$releasever/extras/$basearch/os/' >> /etc/yum.repos.d/CentOS-Linux-Extras.repo
yum clean all
yum makecache
```
## Centos 常用包

```bash
yum -y install gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng \
libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib \
zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel \
ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel \
krb5 krb5-devel libidn libidn-devel open openssl openssl-devel \
openldap openldap-devel nss_ldap openldap-clients openldap-servers \
libmcrypt libmcrypt-devel mhash mhash-devel automake cmake emacs vimnn
```

## RPM 常用命令

```bash
# 安装
rpm -ivh --force ./*.rpm
# 查询
rpm -qa | grep git
# 删除
rpm -e --nodeps git
```

## Centos 导出 RPM 包

```
# 方法一:
# 要使用--downloadonly选项，需要先安装yum-plugin-downloadonly，不安装该包的话，
# 会报下面的错误信息：Command  line error: no such option: --downloadonly
yum install --downloaddir=/tmp/package/ --downloadonly tcpdump

# 方法二:
# 使用yumdownloader     需要先安装yum-utils。
repotrack tcpdump
yumdownloader tcpdump
```

## 容器sshd
```bash
> ["/bin/sh", "-c", "yum install -y openssh-server && sed -i 's/[# ]*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config &&  ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' && /sbin/sshd && echo root:root | chpasswd"]
```
