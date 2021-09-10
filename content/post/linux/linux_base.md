---
title: "Linux基础"
date: 2021-09-10T22:27:00+08:00
lastmod: 2021-09-10T22:27:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## whatis

whatis 命令是用于查询一个命令的功能，并将查询结果打印到终端上。 whatis 命令在 man -w 显示的文件中查找 command 参数指定的命令、系统调用、库函数或特殊文件名。whatis 命令显示手册部分的页眉行，还能能看到该命令的其他章节的内容。whatis 命令等同于使用 man -f 命令。

## whereis

whereis 省略参数，则显示所有文件；
-b 定位可执行文件
-m 定位帮助文件
-s 定位源码文件
-u 搜索默认路径下除可执行文件、源代码、帮助文件意外的其他文件
-B 指定搜索执行文件路径
-M 指定搜索帮助文件路径
-S 指定搜索源代码文件路径

## man

-a 在所有的 man 帮助手册中搜索
-f 等价于 whatis 指令，显示给定关键字的简短描述信息；
-P 指定内容时使用分页程序
-M 指定 man 手册搜索的路径
-k 指令/文件：模糊查询，用此参数将列出整个 man page 中个所查内容相关的内容，即它将同时查找指令/文件名，和相应的说明的内容，只要包含有所查找的内容就会被列出。

### man 的章节号

| 章节号 | 含义                                          |
| ------ | --------------------------------------------- |
| 1      | 用户在 shell 环境中可以实现的命令或可执行文件 |
| 2      | 系统内核可调用的函数和工具                    |
| 3      | 一些常见的函数与函数库，大部分为 C 的函数库   |
| 4      | 一些常见的函数与函数库，大部分为 C 的函数库   |
| 5      | 配置文件或者某些文件的格式                    |
| 6      | 游戏                                          |
| 7      | 惯例与协议，例如 Linux 文件系统、网络协议等   |
| 8      | 系统管理员可使用的管理命令                    |
| 9      | 跟 kernel 有关的文件                          |
| 10     | 开发者章节                                    |
