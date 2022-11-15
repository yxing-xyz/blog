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

> java、php和数据连接池之类需要调整合适的线程、进程数，因为同步阻塞模型需要很多线程来接受请求和数据库连接池数量可以让请求不要停留业务服务器而是停留数据库服务器，提高并发，而Nginx之类worker设置cpu核心数就可以了，因为nginx异步模型会全力工作，只需要减少进程数保证一核心一个work进程避免内核调度进程切换耗费资源,说明内核和用户上下文切换很耗费资源。

> 走公网插入mysql的性能耗时大概网络20ms, 通过线程池并发提供句柄给上层应用使用能提高吞吐量.

> nginx默认目录会重定向pathinfo后面追加/符号

> nginx配置absolute_redirect off会使用Localtion相对路径

# k8s
> pod中有一个隐藏的pause容器, 它的源码很简单十几行c代码, 主要是监听信号处理, 实际的作用就是当pod是共享PID命名空间的时候, pause作为init进程, 回收子进程退出的资源. 其实没有必要了, 阿里云上的默认PID不共享, 所以没啥意义还浪费资源

> ipvs在udp使用的时候会有一个超时可以用ipvsadm -L --tiemout查看，默认300s， 这个会导致coredns重启300s内会有卡吨现象，因为ipvs未转换vip成实际ip

> k8s是根据request进行伸缩和创建pod，所以request设置太大存在资源浪费，太小容易导致扩容太多个。所以可以关闭伸缩，查看cpu和内存，然后调整request，limit，最后开启伸缩调整伸缩数量

> coredns根据cpu和内存伸缩效果不明显，应该是udp svc负载均衡不平衡，所以有一个autoscaler线性组件,可以根据configmap的自定义公式控制coredns数量

> k8s默认不会主动将已运行pod平衡分布机器，有一个descheduler可以三分钟运行一次平衡pod数量

> k8s统计显示的内存是包括实际用的top里的RES和系统buffer/cache占用的内存

> k8s的drain节点是先结束pod然后新建pod,所以如果pod是高可用的分布在不同节点drain没问题,如果节点少,且有资源的pod全位于同一个node上那么drain会中断业务,建议先cordon,然后restart相关资源直到node没有业务pod后才移除node

> pod停止流程![avatar](/img/pod-stop.png)

> k8s的nginx-ingress是订阅了endpoints然后nginx重新加载后端ip地址, 因为k8s重启更新资源并不保证同步nginx的监听,只保证node更新ipvs端点.所以前端是nginx-ingress,后端的服务最好在prestop里sleep一定时间,保证nginx同步更新端点后再结束pod, 如果是svc的ip调用不需要,因为k8s保证了同步更新

> istio的tls认证放在一个istio网关上， virutalservice和gateway放在同一个命名空间下。 如果跨网关使用同样的证书，或者跨命名空间使用同样的证书是不生效的

> 自定义kube-sheduler的时候如果开启高可用默认情况会竞争kube-system命名空间的lease资源名kube-sheduler, 但是这个资源被default-sheduler锁定了导致启动不了所以需要换资源名或者命名空间

> ingress不能跨命名空间, 可以在ingress的命名空间里自定义endpoint来实现跨命名空间

#  重启pod
都是修改yaml达到重启的目的比如set image, 只是功能上需要做阻塞(解决全部重启雪崩效应), replace是阻塞替换, restart是非阻塞需要加status
## 1. patch或者replace

```bash
kubectl patch deployment web -p \
  "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"date\":\"`date +'%s'`\"}}}}}"

kubectl get pod web-kw86d -o yaml | kubectl replace --force -f -
```
## 2. rollout
```bash
# 重启
kubectl rollout restart deployment web
# 等待重启完毕
kubectl rollout status deployment/web
```
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
18. 阿里云ECS禁用了25端口, 建议用80做SSL端口邮件推送
```
