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
常见发行版更换mirror
1. Debian
2. Centos7
3. Centos8 Stream
<!--more-->

## Debian 11
```bash
sed -i 's#\w*\.debian\.org#mirrors\.tencent\.com#g' /etc/apt/sources.list
```
## Debian 12
```bash
sed -i 's#\w*\.debian\.org#mirrors\.tencent\.com#g' /etc/apt/sources.list.d/debian.sources
```
## Centos
```bash
sed -i.bak \
    -e 's|^mirrorlist=|#mirrorlist=|' \
    -e 's|^#baseurl=|baseurl=|' \
    -e 's|http://mirror.centos.org|https://mirrors.tencent.com|' \
    /etc/yum.repos.d/CentOS-*.repo    #要修改的对象文件
yum clean all
yum makecache
```