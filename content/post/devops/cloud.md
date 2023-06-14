---
title: "云"
date: 2021-07-10T12:32:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "运维"
tags:
  - "运维"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 阿里云的网络问题总结
2. 阿里云k8s的一些问题总结
3. 阿里云ECS发送邮件问题总结
<!--more-->
## 阿里云
```txt
1. 负载均衡四层后端负载访问负载均衡是访问不通
2. 同一个交换机的route配置需要在路由表上配置，在系统上配没用，估计是vxlan的原因。
3. 阿里云托管版的pod路由是下沉到路由表，service是通过kubeproxy和iptables处理的
4. 阿里云的路由表能自定义路由表拓展自定义网段配和桥接的VPN如ipsec/ikev2和openvpn
5. 阿里云专有版是自定义master节点，但是负载均衡配置service的local模式默认不会把master节点加入集群
6. k8s默认的组件需要注意coredns和nginx-ingress/istio的性能瓶颈
7. 有一些默认不支持nas和oss挂载存储如zentao和mysql, 可能因为应用使用到Linux文件特殊特性, 且不支持远程文件系统
8. 阿里云网关对自定义网段不支持SNAT, 所以自定义网段先SNAT成ECS上专有网段IP, 才会被阿里云网关SNAT
9. k8s默认会将loadbalancer的ip做负载均衡，所以如果在集群内部四层访问负载均衡是不会触发第一点的。
10. svc负载聚会如果加service.beta.kubernetes.io/alibaba-cloud-loadbalancer-remove-unscheduled-backend: 'on'会cordon移除slb后端节点
11. slb负载策略wrr(加权轮询),rr(轮训),wlc(加权最小连接数),ch(一致性hash，只有四层有)
12. 调阿里云的网络要注意安全组 ecs-a - 安全组出口 -  vsitch（路由表）- 安全组入口 - ecs-b
                                                    |
                                                  ngw(SNAT)
                                                    |
                                                  internet
13. 阿里云日志的daemonset-crd方式，如果两个k8s集群共用一个logstore，需要重新添加新的机器组，因为重复使用crd会覆盖掉机器组，应用日志采用sidecar-crd方法不会有性能瓶颈
14. 联系方式: 消息中心, 云监控, k8s集群
15. 阿里云的CDN不会将浏览器传递的URL+传递到OSS中，导致如果文件名有+会找不到
16. 托管版k8s复用同一个负载均衡的时候界面不能出现或者注解不能复用某个负载均衡是因为该负载均衡的标签被标记了阿里的ccm就不会更新负载均衡
17. 阿里云ack的k8s集群会将SLB的IP会被IPVS解析转发到后端Node节点上也就是SVCIP的作用, 流量不会到负载均衡,
也就不会触发负载均衡四层协议后端不能同时做客户端和服务端的bug,k8s 1.20.11版本后阿里云的这个特性会收到svc的流量策略影响,如果是cluster那么会同步到所有node设置ipvs后端节点, 如果是local那么只会同步当前有svc后端pod的node.
意思就是local如果node上有这个pod那么就会直接转发不走负载均衡, 没有pod那么connect refuse, cluster不管三七二十一全都不走负载均衡, 不过阿里云自身新增注解可以设置全都走负载均衡
1.  阿里云ECS禁用了25端口, 建议用80做SSL端口邮件推送
```
