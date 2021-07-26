---
title: "运维笔记"
date: 2021-07-10T12:32:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "DevOps"
tags:
  - "note"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## 基础
> du和df空间不一致: 1. rm删除文件inode节点被进程打开内核不会释放空间. 2. mount挂载非空目录隐藏了原磁盘导致du并没有统计这部分空间
> PHP必须要开启opcache，不然会挂在磁盘并发请求打挂系统，cpu利用率也上不去

> redis万不得以不要存放永久数据，最好设置ttl

> java、php和数据连接池之类需要调整合适的线程、进程数，因为同步阻塞模型需要很多线程来接受请求和数据库连接池数量可以让请求不要停留业务服务器而是停留数据库服务器，提高并发，而Nginx之类worker设置cpu核心数就可以了，因为nginx异步模型会全力工作，只需要减少进程数保证一核心一个work进程避免内核调度进程切换耗费资源

> ipvs在udp使用的时候会有一个超时可以用ipvsadm -L --tiemout查看，默认300s， 这个会导致coredns重启300s内会有卡吨现象，因为ipvs未转换vip成实际ip

> k8s是根据request进行伸缩和创建pod，所以request设置太大存在资源浪费，太小容易导致扩容太多个。所以可以关闭伸缩，查看cpu和内存，然后调整request，limit，最后开启伸缩调整伸缩数量

> coredns根据cpu和内存伸缩效果不明显，应该是udp svc负载均衡不平衡，所以有一个autoscaler线性组件,可以根据configmap的自定义公式控制coredns数量

> k8s默认不会主动将已运行pod平衡分布机器，有一个descheduler可以三分钟运行一次平衡pod数量

## 阿里云
```txt
1. 负载均衡四层后端负载访问负载均衡是访问不通
2. 同一个交换机的route配置需要在路由表上配置，在系统上配没用，估计是vxlan的原因。
3. 阿里云托管版的pod路由是下沉到路由表，service是通过kubeproxy和iptables处理的
4. 阿里云的路由表能自定义路由表拓展自定义网段配和桥接的VPN如ipsec/ikev2和openvpn
5. 阿里云专有版是自定义master节点，但是负载均衡配置service的local模式默认不会把master节点加入集群
6. k8s默认的组件需要注意coredns和nginx-ingress/istio的性能瓶颈
7. 有一些默认不支持nas和oss挂载存储如zentao和mysql
8. 自定义网段不支持阿里云网关nat出口
9. k8s默认会将loadbalancer的ip做负载均衡，所以如果在集群内部四层访问负载均衡是不会触发第一点的。
10. 调阿里云的网络要注意安全组 ecs-a - vsitch（路由表） - 安全组 - ecs-b
                                     |
                                    ngw(SNAT)
                                     |
                                    internet
11. 阿里云日志的daemonset-crd方式，如果两个k8s集群共用一个logstore，需要重新添加新的机器组，
因为重复使用crd会覆盖掉机器组，应用日志采用sidecar-crd方法不会有性能瓶颈
```
