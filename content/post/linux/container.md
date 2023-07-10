---
title: "容器"
date: 2018-06-21T14:55:46+08:00
lastmod: 2023-06-12T15:35:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. ctr/runc/containerd/docker/podman/k8s
2. Namespace
<!--more-->
## ctr
### 基本命令
##### 创建容器
```bash
ctr c create -t --mount 'type=bind,src=/data/,dst=/data/,options=rbind:ro' --net-host docker.io/library/busybox:latest busybox
```
## runc
#### 列出启动的所有容器
```bash
runc --root /run/containerd/runc/default list
```
## containerd
### 容器主流程
client(ctr/nerctl/crictrl)  => contaierd => containerd-shim-runc-v2 => runc
nerdctrl会生成cni的配置文件到/etc/cni/net.d, 如果不存在的话,
其中containerd-shim-runc-v2会将容器spec信息写入到容器runc根目录的config.json,
其中hook字段描述容器的生命周期执行时间, 会触发命令的执行, 网络也是这个时候创建的,
runc会触发钩子, 然后nerdctl会用cni配置文件生成配置信息, cni持久数据位于/var/lib/cni比如最后一个使用IP, nerdctl持久数据位于/var/lib/nerdctl
### 容器网络通信
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
## docker
### 进入Mac的docker虚拟机
```bash
docker run -it --rm --privileged --pid=host justincormack/nsenter1
```
### Docker启动sshd
```bash
["/bin/sh", "-c", "apt update && apt install -y openssh-server && sed -i 's/[# ]*UsePAM.*/UsePAM no/' /etc/ssh/sshd_config && sed -i 's/[# ]*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && && service ssh restart && echo root:root | chpasswd"]
```
### 跨平台架构
#### Manifest合并多架构镜像
```bash
docker manifest rm ccr.ccs.tencentyun.com/yxing-xyz/linux:arch
docker manifest create ccr.ccs.tencentyun.com/yxing-xyz/linux:arch \
ccr.ccs.tencentyun.com/yxing-xyz/linux:arch-amd64 \
ccr.ccs.tencentyun.com/yxing-xyz/linux:arch-arm64

docker manifest push ccr.ccs.tencentyun.com/yxing-xyz/linux:arch
```
#### buildx
加入试验特性或者命令行添加环境变量DOCKER_BUILDKIT=1
```bash
vim /etc/docker/daemon.json
#添加配置
{
	"experimental": true
}
```
binfmt_misc是Linux内核的一项功能，其使得内核可识别任意类型的可执行文件格式并传递至特定的用户空间应用程序，如模拟器和虚拟机[1]。

*下载linux下qemu二进制翻译器*

`https://github.com/multiarch/qemu-user-static/releases`
```bash
# 内核清空binfmt
docker run --rm --privileged multiarch/qemu-user-static --reset
# 内核注册binfmt
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
# 创建构建容器,使用构建容器
docker buildx create --use --name mybuilder
# 在检查之前确保构建器已启动
docker buildx inspect --bootstrap
```
*自动下载安装二进制翻译器*
```bash
# 安装全部模拟器
docker run --privileged --rm tonistiigi/binfmt --install all
# 安装指定的模拟器
docker run --privileged --rm tonistiigi/binfmt --install arm64,riscv64,arm
# 卸载指定模拟器
docker run --privileged --rm tonistiigi/binfmt --uninstall qemu-aarch64
```
构建多架构镜像
为确保构建容器能拉取到正确平台的基础镜像，可显式在FROM后指定平台参数 TARGETPLATFORM 或 BUILDPLATFORM，由buildx自动传递。
```bash
tee > Dockerfile <<EOF
FROM --platform=\$TARGETPLATFORM ccr.ccs.tencentyun.com/yxing-xyz/linux:arch as base
RUN pacman -Syu --needed --noconfirm --overwrite '*'

FROM scratch
COPY --from=base / /
EOF
DOCKER_BUILDKIT=1 docker buildx build -t ccr.ccs.tencentyun.com/yxing-xyz/linux:arch --no-cache --platform linux/arm64,linux/amd64 . --push
```
#### COPY和ADD的联系和区别
联系:

1. 两者都能将文件和目录拷贝到镜像中

区别:

1. ADD自动解压压缩文件到镜像中

2. ADD能重URL中拷贝到镜像中但是不推荐，因为会创建更多的镜像层
#### ENTRYPOINT和CMD的联系和区别

区别:
ENTRYPOINT的作用不同, 如果你希望你的docker镜像只执行一个具体程序,
不希望用户在执行docker run的时候随意覆盖默认程序. 建议用ENTRYPOINT

使用:

在写Dockerfile时, ENTRYPOINT或者CMD命令会自动覆盖之前的ENTRYPOINT或者CMD命令.
在docker镜像运行时, 用户也可以在命令指定具体命令, 覆盖在Dockerfile里的命令.
和CMD类似, 默认的ENTRYPOINT也在docker run时, 也可以被覆盖. 在运行时, 用--entrypoint覆盖默认的ENTRYPOINT

写法:
ENTRYPOINT和CMD指令支持2种不同的写法: shell表示法和exec表示法.
当使用shell表示法时, 命令行程序作为sh程序的子程序运行, docker用/bin/sh -c的语法调用.
PID为1的进程并不是在Dockerfile里面定义的ping命令, 而是/bin/sh命令. 如果从外部发送任何POSIX信号到docker容器,
由于/bin/sh命令不会转发消息给实际运行的ping命令, 则不能安全得关闭docker容器

永远使用Exec表示法
```bash
CMD ["executable","param1","param2"]
```

组合使用:
组合使用ENTRYPOINT和CMD, ENTRYPOINT指定默认的运行命令, CMD指定默认的运行参数
## Podman
### 兼容docker前端
```bash
export DOCKER_HOST=unix:///Users/x/.local/share/containers/podman/machine/podman-machine-default/podman.sock
```
### Mac虚拟机初始化
```bash
podman machine init --cpus 8 --memory 16384 --disk-size=128 --image-path stable --rootful --now
# 默认IP和路由
# ip addr add 192.168.127.2/24 dev enp0s1
# ip route add default via 192.168.127.1
```
### X Server映射到容器内部
```bash
podman run -it --name arch-amd64 --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" docker.io/archlinux
```
## k8s
* pod中有一个隐藏的pause容器, 它的源码很简单十几行c代码, 主要是监听信号处理, 实际的作用就是当pod是共享PID命名空间的时候, pause作为init进程, 回收子进程退出的资源. 其实没有必要了, 阿里云上的默认PID不共享, 所以没啥意义还浪费资源

* ipvs在udp使用的时候会有一个超时可以用ipvsadm -L --tiemout查看，默认300s， 这个会导致coredns重启300s内会有卡吨现象，因为ipvs未转换vip成实际ip

* k8s是根据request进行伸缩和创建pod，所以request设置太大存在资源浪费，太小容易导致扩容太多个。所以可以关闭伸缩，查看cpu和内存，然后调整request，limit，最后开启伸缩调整伸缩数量

* coredns根据cpu和内存伸缩效果不明显，应该是udp svc负载均衡不平衡，所以有一个autoscaler线性组件,可以根据configmap的自定义公式控制coredns数量

* k8s默认不会主动将已运行pod平衡分布机器，有一个descheduler可以三分钟运行一次平衡pod数量

* k8s统计显示的内存是包括实际用的top里的RES和系统buffer/cache占用的内存

* k8s的drain节点是先结束pod然后新建pod,所以如果pod是高可用的分布在不同节点drain没问题,如果节点少,且有资源的pod全位于同一个node上那么drain会中断业务,建议先cordon,然后restart相关资源直到node没有业务pod后才移除node

* pod停止流程![pod停止流程](/img/pod-stop.png)

* k8s的nginx-ingress是订阅了endpoints然后nginx重新加载后端ip地址, 因为k8s重启更新资源并不保证同步nginx的监听,只保证node更新ipvs端点.所以前端是nginx-ingress,后端的服务最好在prestop里sleep一定时间,保证nginx同步更新端点后再结束pod, 如果是svc的ip调用不需要,因为k8s保证了同步更新

* stio的tls认证放在一个istio网关上， virutalservice和gateway放在同一个命名空间下。 如果跨网关使用同样的证书，或者跨命名空间使用同样的证书是不生效的

* 自定义kube-sheduler的时候如果开启高可用默认情况会竞争kube-system命名空间的lease资源名kube-sheduler, 但是这个资源被default-sheduler锁定了导致启动不了所以需要换资源名或者命名空间

* ingress不能跨命名空间, 可以在ingress的命名空间里自定义endpoint来实现跨命名空间

###  重启pod
都是修改yaml达到重启的目的比如set image, 只是功能上需要做阻塞(解决全部重启雪崩效应), replace是阻塞替换, restart是非阻塞需要加status
#### 1. patch或者replace
```bash
kubectl patch deployment web -p \
  "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"date\":\"`date +'%s'`\"}}}}}"

kubectl get pod web-kw86d -o yaml | kubectl replace --force -f -
```
#### 2. rollout
```bash
# 重启
kubectl rollout restart deployment web
# 等待重启完毕
kubectl rollout status deployment/web
```
## Namespace
nsenter关联命名空间原理:
open要进入/proc/${PID}的namespace得到fd, 然后setns传入fd修改当前进程的命名空间, 然后execvp执行一个可执行文件(替换当前进程的代码段)

unshare分离进程原理:
unshare命令调用unshare函数分离指定命名空间, 然后处理命令行参数比如改变根目录, 改变工作目录目录等, 然后execvp替换当前进程

```bash
# 使用指定进程pid的namespace执行命令
nsenter -t 119324 -a /bin/ps -ef

# 创建namespace, --mount-proc参数是让unshare自动重新mount /proc目录
unshare --uts --pid --mount --fork --mount-proc /bin/bash
```