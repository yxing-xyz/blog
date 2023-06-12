---
title: "源"
date: 2021-06-01T16:52:00+08:00
lastmod: 2023-06-12T16:52:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## Debian Mirrors
```bash
sed -i 's#\w*\.debian\.org#mirrors\.tencent\.com#g' /etc/apt/sources.list
```
## Centos7换源
```bash
sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.tencent.com/centos|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-Base.repo
```
## Centos8 Stream换源
```bash
sed -i.bak \
    -e 's|^mirrorlist=|#mirrorlist=|' \
    -e 's|^#baseurl=|baseurl=|' \
    -e 's|http://mirror.centos.org|https://mirrors.tencent.com|' \
    /etc/yum.repos.d/CentOS-*.repo    #要修改的对象文件
yum clean all
yum makecache
```