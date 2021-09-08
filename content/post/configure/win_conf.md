---
title: "Windows Configuration"
date: 2020-05-04T12:00:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Configure"
tags:
  - "Windows"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
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
## Winget
```
aria2
cmake
curl
dig
firacode
gcc
gdb
git
go
chrome
mobaxterm
netcat
nmap
nodejs
sumatrapdf
vlc
vscode
winmtr
wireshark
yasm
lockhunter
recuda
lua
listary
qemu
rustup
qbittorrent
TortoiseSVN
ccleaner
```
## Win 配置文件

- <a href="/windows/Microsoft.PowerShell_profile.ps1" target="_blank">Microsoft.PowerShell_profile.ps1</a>

```ps1
mv Microsoft.PowerShell_profile.ps1 $PROFILE -FORCE
```


## win重置网络
```cmd
ipconfig /release
ipconfig /renew
```