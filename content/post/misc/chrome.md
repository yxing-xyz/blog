---
title: "Chrome"
date: 2022-05-01T16:55:00+08:00
lastmod: 2022-05-01T16:55:00+08:00
draft: false
categories:
  - "杂项"
tags:
  - "杂项"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 解决高版本chrome内网页加载内网资源被组织
2. 无痕窗口模式缓存问题
<!--more-->
## 解决高版本chrome内网页加载内网资源被组织
```txt
1. chrome://flags/#block-insecure-private-network-requests配置chrome选项为disable
2. 访问者资源加响应头  Access-Control-Allow-Private-Network
```

## 无痕窗口模式缓存
无痕窗口模式多个窗口之间会共享缓存,所以需要全部关闭无痕窗口新建才有效。
