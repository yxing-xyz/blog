---
title: "Shell"
date: 2023-06-12T16:08:00+08:00
lastmod: 2023-06-12T16:08:00+08:00
draft: false
categories:
  - "编程"
tags:
  - "编程"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 管道运算符
2. job任务
<!--more-->
## 基础

## env,set,export

1. env: 程序，子进程继承shell的环境变量，打印进程环境变量
2. set: set是shell内置的命令，用户显示该shell进程的shell变量以及该shell进程的环境变量
3. export: 把一个shell变量变作环境变量。export不加参数的时候，显示哪些变量被导出成了用户变量
### 疑难解析
环境变量是一个进程的属性，shell是一个进程所以也有环境变量, 而且子进程会继承父进程的环境变量，

所以shell脚本和交互式shell中export设置的变量子进程都会继承放到环境变量属性中，当你在命令前设置变量，

shell会临时给该命令(子进程)设置环境变量
* 在交互式shell中直接设置变量是设置当前shell的本地shell变量，不会影响子进程变量(env), 影响shell变量集(set)。
* 在交互式shell中命令前面设置变量是在该子进程的环境变量中设置变量，会影响子进程环境变量(env)，不会影响shell变量集(set)
* 在交互式shell中export会将变量放到shell环境变量和shell变量集中，会影响子进程环境变量(env), 会影响shell变量集(set)
* 当shell执行脚本的时候，是新创建一个shell子进程执行脚本,会继承父进程shell的环境变量
### 管道运算符 |
管道运算符只能传递stdout输出, 如果stderr如果要管道传输需要重定向2>&1

### 任务
jobs 列出属于当前用户的进程

bg 将进程搬到后台运行（Background）

fg 将进程搬到前台运行（Foreground