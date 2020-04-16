---
title: "Docker"
date: 2018-06-21T14:55:46+08:00
description: "Docker操作"
categories:
  - "DevOps"
tags:
  - "DevOps"
thumbnail: "/img/docker.png" # Thumbnail image
lead: "Docker 是一个开放源代码软件，是一个开放平台，用于开发应用、交付（shipping）应用、运行应用。Docker容器 与虚拟机类似，但原理上，容器是将操作系统层虚拟化，虚拟机则是虚拟化硬件，因此容器更具有便携性、高效地利用服务器" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

## 安装

### Centos

```bash
# step 1: 安装必要的一些系统工具
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# Step 2: 添加软件源信息
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# Step 3: 更新并安装 Docker-CE
sudo yum makecache fast
sudo yum -y install docker-ce
pip install docker-compose
# Step 4: 启动
sudo systemctl start docker
sudo systemctl enable docker
```

### Ubuntu

```bash
# step 1: 安装必要的一些系统工具
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# step 2: 安装GPG证书
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# Step 3: 写入软件源信息
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
# Step 4: 更新并安装 Docker-CE
sudo apt-get -y update
sudo apt-get -y install docker-ce
pip install docker-compose
# Step 5: 启动
sudo systemctl start docker
sudo systemctl enable docker
```

## 配置

### 配置 docker 镜像

```bash
# 自己申请阿里云https加速地址替换掉
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
"registry-mirrors": ["https://6kbwr476.mirror.aliyuncs.com"],
"log-driver":"json-file",
"log-opts":{ "max-size" :"100m","max-file":"1"}
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## 基本命令

### 拉取操作系统镜像

```bash
docker pull centos # 镜像可以去docker hub中搜索自己需要的
```

### 镜像列表

```bash
docker images
```

### 普通模式运行镜像

```bash
docker run --rm -dit --name pqcloud-web \ # 创建容器名
    -p 8090:8080 \ # 宿主机端口:容器内部端口
    --label aliyun.logs.pqcloud-web=stdout \
    -h 01 \ # 容器Hostname
     registry.cn-hangzhou.aliyuncs.com/pqtel/pqcloud-web # 远程拉取地址
```

### 容器和宿主机文件拷贝

```bash
#从主机复制到容器
docker cp 宿主机路径 容器ID或Name:容器路径

#从容器复制到主机
docker cp 容器ID或Name:容器路径 宿主机路径
```

### 停止、删除容器和镜像

```bash
# 单个删除容器和镜像
docker stop id或name
docker rm   id或name
docker rmi  id或name
# 停止所有容器
docker stop $(docker ps -aq)
# 删除所有容器
docker stop $(docker ps -aq) & docker rm $(docker ps -aq)
# 删除全部容器和镜像
docker stop $(docker ps -aq) & docker rm $(docker ps -aq) & docker image prune -af
# 删除所有的无名镜像(会导致所有容器删除)
docker stop $(docker ps -aq) & docker rm $(docker ps -aq) & docker rmi $(docker images -qf "dangling=true")
```

### 进入容器 Shell

```bash
docker exec -it 容器名 /bin/bash # 有些容器没有bash只有sh
```

### 所有 docker 打印的日志收集存储到 Elasticsearch

```bash
docker run -dit \
    --rm registry.cn-hangzhou.aliyuncs.com/acs-sample/log-pilot \
    --restart=always \
    --name log-pilot \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /:/host \
    --privileged  \
    -e FLUENTD_OUTPUT=elasticsearch \
    -e ELASTICSEARCH_HOST=地址 \
    -e ELASTICSEARCH_PORT=端口 \
    -h 主机名 \
    registry.cn-hangzhou.aliyuncs.com/acs-sample/log-pilot
```
