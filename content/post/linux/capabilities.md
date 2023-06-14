---
title: "Capabilities"
date: 2022-09-28T13:49:00+08:00
lastmod: 2022-09-28T13:49:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
在Linux内核2.2之前，为了检查进程权限，将进程区分为两类：特权进程(euid=0)和非特权进程。特权进程(通常为带有suid的程序)可以获取完整的root权限来对系统进行操作。

在linux内核2.2之后引入了capabilities机制，来对root权限进行更加细粒度的划分。如果进程不是特权进程，而且也没有root的有效id，系统就会去检查进程的capabilities，来确认该进程是否有执行特权操作的的权限。

可以通过man capabilities来查看具体的capabilities。

Linux capabilities 分为进程 capabilities 和文件 capabilities。

对于进程来说，capabilities 是细分到线程的，即每个线程可以有自己的capabilities。对于文件来说，capabilities 保存在文件的扩展属性中。

linux的线程拥有的capabilities一共有五种。
<!--more-->
## capabilities
### 进程capabilities
* Permitted

它是Effective和Inheritable的超集。进程拥有的权限不会超过这个集合。如果一个进程在Permitted集合中丢失一个能力，它无论如何不能再次获取该能力(除非特权用户再次赋予它)
* Inheritable

它是表明该进程可以通过execve继承给新进程的能力。包含在该集合中的 capabilities 并不会自动继承给新的可执行文件，即不会添加到新线程的 Effective 集合中，它只会影响新线程的 Permitted 集合。
* Effecitive

进程的有效能力集，Linux内核真正检查的能力集。
* Bounding

它是 Inheritable 集合的超集，如果某个 capability 不在 Bounding 集合中，即使它在 Permitted 集合中，该线程也不能将该 capability 添加到它的 Inheritable 集合中。
Bounding 集合的 capabilities 在执行 fork() 系统调用时会传递给子进程的 Bounding 集合，并且在执行 execve 系统调用后保持不变。
  1. 当线程运行时，不能向 Bounding 集合中添加 capabilities。
  2. 一旦某个 capability 被从 Bounding 集合中删除，便不能再添加回来。
  3. 将某个 capability 从 Bounding 集合中删除后，如果之前 Inherited 集合包含该 capability，将继续保留。但如果后续从 Inheritable 集合中删除了该 capability，便不能再添加回来。

* Ambient

在Linux内核4.3后增加，用来弥补Inheritable 的不足。它可以用prctl来直接修改。Ambient 具有如下特性：
1. Permitted 和 Inheritable 未设置的 capabilities，Ambient 也不能设置。
2. 当 Permitted 和 Inheritable 关闭某权限后，Ambient 也随之关闭对应权限。这样就确保了降低权限后子进程也会降低权限。
3. 非特权用户如果在 Permitted 集合中有一个 capability，那么可以添加到 Ambient 集合中，这样它的子进程便可以在 Ambient、Permitted 和 Effective 集合中获取这个 capability。



### 文件capabilities
* Permitted

这个集合中包含的 capabilities，在文件被执行时，会与线程的 Bounding 集合计算交集，然后添加到线程的 Permitted 集合中。

* Inheritable

这个集合与线程的 Inheritable 集合的交集，会被添加到执行完 execve() 后的线程的 Permitted 集合中。

* Effective

这不是一个集合，仅仅是一个标志位。如果设置开启，那么在执行完 execve() 后，线程 Permitted 集合中的 capabilities 会自动添加到它的 Effective 集合中。对于一些旧的可执行文件，由于其不会调用 capabilities 相关函数设置自身的 Effective 集合，所以可以将可执行文件的 Effective bit 开启，从而可以将 Permitted 集合中的 capabilities 自动添加到 Effective


### 查看/修改capabilities
linux proc的进程目录有status文件可以查看
```
➜  sudo cat /proc/self/status
CapInh:	0000000000000000
CapPrm:	0000000000000000
CapEff:	0000000000000000
CapBnd:	0000003fffffffff
CapAmb:	0000000000000000
```
capsh: 解析capabilities成文本

setcap: 设置可执行文件的cap

getcap: 查看可执行文件的cap

### 编程
可以链接libcap来操作cap