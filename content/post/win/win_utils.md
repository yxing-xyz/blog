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

## Close security center

```
1. win+R打开运行小窗口，输入regedit，按回车键进入注册表编辑器。

2. 定位到 HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService

3. 在右侧找到DWORD（32位）值，命名为Start。

4. 修改数值数据为4。

5. 重启文件资源管理器，或注销再登录/重启系统。
```

## Deleting folders with PowerShell

```ps1
Remove-Item 文件夹路径 -Recurse -Force -Confirm:$false
# Get-ChildItem $directoryPath -Recurse | Remove-Item -Force
```
