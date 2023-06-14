---
title: "Linux Kernel"
date: 2021-10-08T17:52:00+08:00
lastmod: 2021-10-08T17:52:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 内核模块加载
2. rfkill/udev等工具
<!--more-->
## module
### Linux模块加载
1. 模块保存在`/lib/modules/`下。
2. 使用`/etc/modules-load.d/`来配置系统启动时加载哪些模块。
3. 使用`/etc/modprobe.d/`下配置模块加载时的一些参数，
也可以利用blacklist来屏蔽模块的自动加载。

### 如何添加一个自己编译的模块
1. 将编译好的.ko模块放到目录`/lib/modules/$(uname -r)/`
2. 注意特别重要的一步：在命令行输入命令`depmod`，此命令是用来更新模块启动配置表的，没有`depmod`这个命令，就无法使用modprobe命令来启动模块。
3. 为`*.modules`文件加可执行权限，我这里这就执行：`chmod 755 helloworld.modules`

## rfkill
rfkill是一个内核级别的管理工具，可以打开和关闭设备的蓝牙和wifi。
```bash
rfkill list
```
## udev
```bash
### 监听所有活动
udevadm monitor
### 重新加载配置
udevadm control --reload-rules
### 再次触发udev事件
udevadm trigger
# 查看设备的sysfs属性
udevadm info -q all -a /dev/input/event13
```
