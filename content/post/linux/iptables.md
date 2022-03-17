---
title: "Linux IPtables"
date: 2021-09-02T16:17:00+08:00
lastmod: 2021-09-02T16:17:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

![avatar](/img/iptables.png)
# 五表五链
```txt
security表：主要针对的是数据链路层的管理规则组合，只不过它是基于target目标来操作的。

filter表：是netfilter中最重要的表，也是默认的表，主要负责数据包的过滤功能

nat表：主要实现网络地址转换的表。可以自由转换数据报文中的ip和port

mangle表：主要实现数据包的拆分-修改-封装动作

raw表：通过关闭nat表的追踪功能，从而实现加速防火墙过滤的表
```
```txt
prerouting：数据包进行路由决策前应用的规则，一般用于改变数据包的目标地址，不让别人知道我找的是谁（对进入的数据包进行预处理）

input：数据包经由路由决策后，进入到本机处理时应用的规则，一般用于本机进程处理的数据包（数据包本机处理）

output：新建数据包经路由决策后，从本机输出时应用的规则，一般用于本机处理后的数据包（数据包本机发出）

forward：数据包经由路由决策后，本机不做处理，仅仅是转发数据包时应用的规则（数据包本机转发）

postrouting：数据包从本机出去前，对数据包应用的规则，一般用于更改数据包的源地址信息，不让给别人知道我是谁（对输出的数据包进行预处理）

常见的场景：

本机处理数据包：prerouting->input

本机转发数据包：prerouting->forward->postrouting

本机相应数据包：output->postrouting
```
# 查看NAT
```bash
sudo conntrack -L -j
```


# MTU
```bash
tracepath baidu.com
```
