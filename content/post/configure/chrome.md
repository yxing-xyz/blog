---
title: "chrome"
date: 2022-05-01T16:55:00+08:00
lastmod: 2022-05-01T16:55:00+08:00
draft: false
categories:
  - "Configure"
tags:
  - "Linux"
  - "Windows"
  - "Mac"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## 网页加载内网资源
公网网页加载内网资源会被高版本chrome阻止, 解决方案
```txt
1. chrome://flags/#block-insecure-private-network-requests配置chrome选项为disable
2. 访问者资源加响应头  Access-Control-Allow-Private-Network
```
