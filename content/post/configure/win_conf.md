---
title: "Windows Configuration"
date: 2020-05-04T12:00:00+08:00
description: "Windows Configuration"
categories:
  - "Windows"
tags:
  - "Configure"
# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "Windows Configuration" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

### Scoop 安装

**最好开启代理然后再去执行脚本安装**

```ps1
IF ($PSVersionTable.PSVersion.Major -lt 3 -or $PSVersionTable.CLRVersion.Major -lt 4) {
  return "PowerShell版本高于3且.NET Franmework高于4"
}

# env
# $env:SCOOP='D:\scoop'
# [Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP_GLOBAL, 'Machine')

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')


# conf
scoop install git 7zip aria2
scoop config aria2-max-connection-per-server 16
scoop config aria2-split 16
scoop config aria2-min-split-size 1M

# bucket
scoop bucket add main
scoop bucket add extras
scoop bucket add nerd-fonts

scoop install googlechrome firefox vlc
scoop install curl dig netcat winmtr nmap wireshark
scoop install gcc cmake go nodejs rustup
scoop install hugo
scoop install FiraCode
scoop install vscode qt-creator
scoop install mobaxterm
```

## Win 配置文件

- <a href="/windows/Microsoft.PowerShell_profile.ps1" target="_blank">Microsoft.PowerShell_profile.ps1</a>

```ps1
mv Microsoft.PowerShell_profile.ps1 $PROFILE -FORCE
```
