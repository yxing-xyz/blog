---
title: "蓝牙鼠标"
date: 2022-08-30T22:24:00+08:00
lastmod: 2022-08-30T22:24:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. Linux配置已连接window的蓝牙鼠标
<!--more-->
## 无线蓝牙鼠标双系统共享原理
本质蓝牙鼠标内部只会保留一份配对信息
所以用蓝牙鼠标分别连接不同的操作系统, 会生成对应的配置文件. 然后将最后一个系统的蓝牙鼠标配对信息分发到前面已经连接过的系统中.

## 无线蓝牙鼠标双系统共享步骤
1. 先进入linux使用bluetoothctl连接蓝牙鼠标
  ```bash
  bluetoothctl
  scan on
  pair 无线鼠标的mac地址
  ```
2. 进入windows使用系统蓝牙进行配对蓝牙鼠标
3. 然后下载[PSTools](https://download.sysinternals.com/files/PSTools.zip)解压
4. 进入PSTools解压目录执行下列命令打开注册表
```cmd
PsExec.exe -s -i regedit
```
5. 打开注册表记录蓝牙鼠标参数HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\BTHPORT\Parameters\Keys\\$DEVICE\\$ADDRESS, 记录下面参数
* $DEVICE: 电脑蓝牙MAC地址
* $ADDRESS: 无线鼠标蓝牙地址
* LTK
* ERand
* EDIV
* IRK
* CSRK

6. 进入Linux, 进入var/lib/bluetooth/${DEVICE}/${ADDRESS}, ${ADDRESS}可能和win的不一样, 不一样就将目录重命名和win一样
7. 编辑目录的的info文件具体转换规则如下
```txt
1. LTK对应linux的LongTermKey段落的Key，转换成大写
2. ERand对应LongTermKey段的Rand, 要按相反顺序排列，并且转换成十进制，例如ERand是80070be36385dd2b，
相反顺序重新排列 2bdd8563e30b0780，转换成十进制为3160829177541363584
3. EDIV对应LongTermKey段的EDiv, 转换成十进制
4. IRK对应IdentifyResolvingKey的Key, 转换成大写
5. CSRK对应LocalSignatureKey的Key, 转换成大写
其余可以不用修改,修改完毕，用systemctl restart bluetooth重启蓝牙服务
```

## 引用
[PSTools](https://docs.microsoft.com/zh-cn/sysinternals/downloads/pstools)