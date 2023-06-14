---
title: "Shell语法"
date: 2023-06-12T16:08:00+08:00
lastmod: 2023-06-12T16:08:00+08:00
draft: false
categories:
  - "Program"
tags:
  - "Syntax"
  - "Shell"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
## 基础
### 管道运算符 |
管道运算符只能传递stdout输出, 如果stderr如果要管道传输需要重定向2>&1

### 任务
jobs 列出属于当前用户的进程
bg 将进程搬到后台运行（Background）
fg 将进程搬到前台运行（Foreground