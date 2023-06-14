---
title: "Git"
date: 2023-06-12T16:52:00+08:00
lastmod: 2023-06-12T16:52:00+08:00
draft: false
categories:
  - "命令行"
tags:
  - "命令行"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 只保留最新的一条提交记录
<!--more-->
## git
### 只保留最新的一条提交记录
与`git clone --depth 1`类似, 如果操作当前分支会让当前分支停留在最新提交
```bash
git fetch --depth 1 origin master
```