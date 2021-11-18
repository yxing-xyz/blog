---
title: "中间件"
date: 2021-11-14T13:20:00+08:00
lastmod: 2021-11-14T13:20:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "middleware"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## Redis
redis集群版的lua脚本使用会有一致性问题, 需要确保处理的参数在一个slot下从而保证lua执行的单线程

## RocketMQ
### 事物消息
事物消息是发送一个半消息, 你不提交或回滚半消息, 它不发送实际的消息,客户端定时pull半消息处理, 处理完了会发送到实际消息中,仍然需要消费处理掉
