---
title: "Network"
date: 2021-09-02T16:17:00+08:00
lastmod: 2022-11-13T23:27:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
  - "Network"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

# 设备
## 删除网络设备
```sh
ip link del veth0
```
## 查看设备驱动信息
```sh
## 方法1
ethtool -i eth0

## 方法2
ip -d link show eth0
```

# 查看NAT
```bash
sudo conntrack -L -j
```

# MTU
```bash
tracepath baidu.com
```


# iptables
![avatar](/img/iptables.png)
## 五表五链
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

forward：数据包经由路由决策后，本机不做处理，仅仅是转发数据包时应用的规则（数据包本机转发）

postrouting：数据包从本机出去前，对数据包应用的规则，一般用于更改数据包的源地址信息，不让给别人知道我是谁（对输出的数据包进行预处理）

output：新建数据包经路由决策后，从本机输出时应用的规则，一般用于本机处理后的数据包（数据包本机发出）

常见的场景：

本机处理数据包：prerouting->input

本机转发数据包：prerouting->forward->postrouting

本机相应数据包：output->postrouting
```
## 常用操作
```bash
# 0.放行所有INPUT链流量
iptables -P INPUT ACCEPT
# 1.查看表信息
iptables -t nat -vnL –line-numbers

# 2. 删除链上规则
iptables -t nat -D OUTPUT 1

# 3. 新增自定义链
iptables -t filter -N MY_WEB

# 4. 删除自定义链, 无引用了且空规则才能被删除
iptables -X MY_WEB

```

# tcpdump在网络协议栈的位置
> Wire -> NIC -> tcpdump -> netfilter -> applications -> netfilter -> tcpdump -> NIC -> Wire

因此，使用tcpdump后，可以看到流入网卡的全部数据包，也可以看到流出网卡的所有数据包，但是不一定能看到应用程序返回的数据包。


# 容器网络
## 容器主流程
client(ctr/nerctl/crictrl)  => contaierd => containerd-shim-runc-v2 => runc
nerdctrl会生成cni的配置文件到/etc/cni/net.d, 如果不存在的话, 
其中containerd-shim-runc-v2会将容器spec信息写入到容器runc根目录的config.json, 
其中hook字段描述容器的生命周期执行时间, 会触发命令的执行, 网络也是这个时候创建的, 
runc会触发钩子, 然后nerdctl会用cni配置文件生成配置信息, cni持久数据位于/var/lib/cni比如最后一个使用IP, nerdctl持久数据位于/var/lib/nerdctl

# 容器网络通信
#### 1. 配置网络设备
1. 宿主空间创建网桥作为网关IP
2. 创建虚拟网卡对, 一端插入网桥, 一端移动容器网络命名空间
3. 设置网桥的IP, MASK, 配置路由容器子网段走网桥接口
4. 配置容器网卡端, IP, MASK, 默认路由走网关
**上述步骤即已经实现宿主访问容器网络, 网关IP <=> 容器IP**

#### 2. 外部网络访问容器内部
剩下的问题是如何将容器端口暴露给外部网卡, 使其他机器也能访问, 
其他机器只会路由到宿主机(配置路由器也能, 这里不展开说就有很多种方式, 比如阿里云k8s ACK集群就是做在路由表中)

外部访问的来源有两种
```bash
# 1. 第一种是物理网卡收到物理网卡的IP+端口, 通过nerfilter在NAT表上PREROUTING链将宿主机ip加端口DNAT到容器IP+端口
# 标记包, 主要解决访问localhost
iptables -t nat -A PREROUTING -s 10.4.0.0/24 -p tcp -m addrtype --dst-type LOCAL -m tcp --dport 8080 -j MARK --set-mark 0x2000/0x2000
iptables -t nat -A PREROUTING -s 127.0.0.1/32  -p tcp -m addrtype --dst-type LOCAL -m tcp --dport 8080 -j MARK --set-mark 0x2000/0x2000
iptables -t nat -A PREROUTING -p tcp -m addrtype --dst-type LOCAL -m tcp --dport 8080 -j DNAT --to-destination 10.4.0.2:8080

# 2. 第二种是宿主进程访问访问容器端口, 从OUTPUT出来, 需要在OUT上nat表上进行一次NAT转换, 访问本机网卡接口地址加端口即编程访问容器IP+端口
# 标记包, 主要解决访问localhost
iptables -t nat -A OUTPUT -s 10.4.0.0/24 -p tcp -m addrtype --dst-type LOCAL -m tcp --dport 8080 -j MARK --set-mark 0x2000/0x2000
iptables -t nat -A OUTPUT -s 127.0.0.1/32  -p tcp -m addrtype --dst-type LOCAL -m tcp --dport 8080 -j MARK --set-mark 0x2000/0x2000
iptables -t nat -A OUTPUT -p tcp -m addrtype --dst-type LOCAL -m tcp --dport 8080 -j DNAT --to-destination 10.4.0.2:8080

# 将标记包动态转换, destination目的地址前面已经转换过了, 这里主要将标记的src是127.0.0.1的包转成网关地址访问
iptables -t nat -A POSTROUTING -m mark --mark 0x2000/0x2000 -j MASQUERADE
```

#### 3. 配置容器内部访问外部网络
```bash
# 容器IP访问网段中其他IP, 再次不进行路由表转换
iptables -t nat -A POSTROUTING -s 10.4.0.2/32  -d 10.4.0.0/24 -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.4.0.2/32  ! -d 224.0.0.0/4 -j MASQUERADE
```
