---
title: "终端模拟器"
date: 2022-11-02T17:33:00+08:00
lastmod: 2022-11-02T17:33:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## 终端模拟器
终端模拟器现在一般都是指unix桌面app,它模拟古老的终端显示器.它将键盘事件转为终端序列通过内核tty模块发送个shell进程,其中控制字符被转义成信号,
后端的shell能接收序列绑定特定功能函数,比如bindkey -e使用emacs的按键方式. 它运行前端进程,前端进程能接收所有虚拟号.所以很多GUI程序有文本模式就是基于这个原理.
值得注意的是非法的控制序列没办法模拟发送,所以设置快捷键尽量用转义序列,少用控制序列.

终端模拟器大部分是一个X11的GUI程序, 历史上是一个硬件设备接收文本数据,渲染出来. 有一些终端序列能被特殊解析比如颜色等,
现在我们大部分的彩色终端应用程序都会用到libncurses库的, 他会读取进程的TERM变量然后读取/usr/share/terminfo中对应TERM环境变量的终端信息,
还有一个终端色彩环境变量如COLORTERM=truecolor,如果设置这个变量,终端文本模式会用真彩色渲染到终端模拟器中
容器可能不存在这些文件所以一些如htop等程序会启动报错
```c
// 获取控制终端的前台进程组ID
pid_t pgrpid = tcgetpgrp(STDIN_FILENO);
// 获取控制终端的session组ID
pid_t sid = tcgetsid(STDIN_FILENO);
// 设置控制终端的前台进程组
result = tcsetpgrp(STDIN_FILENO, gid);
```

```bash
# 清空模拟终端
tput clear
# 输出终端多少行
echo $LINES
# 输出终端多少列
echo $COLUMNS
# 查看当前机器支持哪些终端模拟器描述
toe -a
# 查看当前终端模拟器, 在本机的terminfo
infocmp
# 比较两个终端模拟器终端序号区别
infocmp xterm-256color st-256color
# 打印当前终端序列号
showkey -a
```