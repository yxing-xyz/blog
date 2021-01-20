---
title: "Proxy"
date: 2020-05-04T11:39:59+08:00
description: "Proxy"
categories:
  - "Windows"
  - "Linux"
tags:
  - "Shell"
# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "In computer networking, a proxy server is a server application or appliance that acts as an intermediary for requests from clients seeking resources from servers that provide those resources。" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

## CMD

```bat
set http_proxy=http://127.0.0.1:1081
set https_proxy=http://127.0.0.1:1081
```

## PowerShell

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

