---
title: "Redis notes"
description: "Redis notes"
date: 2020-10-16T10:16:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "Redis"
  - "Syntax"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## Redis notes
```sh
# 连接
redis-cli -h host -p port -a 'password'

# 地图经纬度半径查询
GEORADIUS SHOP:COORDINATES 112.936512 28.210319 5000 m WITHCOORD WITHDIST COUNT 20 ASC

# 模糊搜索KEY
KEYS user_id_*

# 模糊清楚KEY
redis-cli -h 'host' -p port -a 'password' KEYS shop_fence_* | xargs  redis-cli -h 'host' -p port -a 'stA#@upid&'  DEL

# 查看KEY有效期
TTL key_name
```
