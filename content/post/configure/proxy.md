---
title: "Proxy"
date: 2020-05-04T11:39:59+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Configure"
tags:
  - "Windows"
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## CMD

```bat
set http_proxy=http://127.0.0.1:1080
set https_proxy=http://127.0.0.1:1080
```

## PowerShell
用vscode编辑profile，profile类似bash的bashrc

```ps1
set-executionpolicy remotesigned
code $PROFILE
```
```ps1
# NOTE: registry keys for IE 8, may vary for other versions
$regPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
function Clear-Proxy
{
    Set-ItemProperty -Path $regPath -Name ProxyEnable -Value 0
    Set-ItemProperty -Path $regPath -Name ProxyServer -Value ''
    Set-ItemProperty -Path $regPath -Name ProxyOverride -Value ''

    [Environment]::SetEnvironmentVariable('http_proxy', $null, 'User')
    [Environment]::SetEnvironmentVariable('https_proxy', $null, 'User')
}

function Set-Proxy
{
    $proxy = 'http://127.0.0.1:1081'

    Set-ItemProperty -Path $regPath -Name ProxyEnable -Value 1
    Set-ItemProperty -Path $regPath -Name ProxyServer -Value $proxy
    Set-ItemProperty -Path $regPath -Name ProxyOverride -Value '<local>'

    [Environment]::SetEnvironmentVariable('http_proxy', $proxy, 'User')
    [Environment]::SetEnvironmentVariable('https_proxy', $proxy, 'User')
}
```

## shell
```bash
# 谷歌启用代理
# google-chrome-stable  --proxy-server="http://127.0.0.1:1081"
export https_proxy='http://127.0.0.1:1081'
export http_proxy='http://127.0.0.1:1081'
```
