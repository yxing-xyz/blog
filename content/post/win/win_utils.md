---
title: "Windows Utils"
date: 2020-05-05T17:00:05+08:00
description: "Windows Utils"
categories:
  - "Windows"
tags:
  - "Utils"
# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "Windows Utils" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---
## CMD关闭防火墙
要用超级管理权限执行
```cmd
::注释 关闭所有防火墙
netsh advfirewall set allprofiles state off
::注释 查看防火墙的状态
netsh advfirewall show allprofiles
```
## CMD启动远程桌面
要用超级管理员权限执行
```cmd
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\Terminal" "Server /v fDenyTSConnections /t REG_DWORD /d 00000000 /f
```
## Close security center

```
1. win+R打开运行小窗口，输入regedit，按回车键进入注册表编辑器。

2. 定位到计算机HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services目录中的SecurityHealthService,wscsvc两个目录

3. 在右侧找到DWORD（32位）值，命名为Start。

4. 修改数值数据为4。

5. 重启文件资源管理器，或注销再登录/重启系统。
```

## Deleting folders with PowerShell

```ps1
Remove-Item 文件夹路径 -Recurse -Force -Confirm:$false
# Get-ChildItem $directoryPath -Recurse | Remove-Item -Force
```

## New-Item
**ItemType**
1. File
2. Directory
3. SymbolLink
4. HardLink
5. Junction
```ps1
New-Item -Path C:\LinkDir -ItemType SymbolicLink -Value F:\RealDir
```
