---
title: "Redis"
description: "Redis"
date: 2020-10-16T10:16:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "编程"
tags:
  - "编程"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 地图经纬度半径查询
<!--more-->
## 地图经纬度半径查询
```sh
GEORADIUS SHOP:COORDINATES 112.936512 28.210319 5000 m WITHCOORD WITHDIST COUNT 20 ASC
```
