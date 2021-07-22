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
