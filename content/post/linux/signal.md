---
title: "信号"
date: 2021-09-10T22:27:00+08:00
lastmod: 2021-09-10T22:27:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
## 信号
### SIGPIPE
对端close socket后收到本机的tcp报文, 会回复一个RST报文, 内核在产生SIGPIPE信号给本机进程退出, 所以tcp程序一般都屏蔽此信号
```c
// 为了避免进程退出，可以捕获 SIGPIPE 信号，或者忽略它，给他设置 SIG_IGN 信号处理函数。
signal(SIGPIPE, SIG_IGN);
```
### SIGCHLD
子进程终止时，或者子进程收到SIGSTOP信号暂停时，或者子进程收到SIGCONT信号后继续运行时，都会发送该信号给父进程。
在父进程fork()之前安装SIGCHLD信号处理函数，并在此handler函数中调用waitpid()等待子进程结束，
这样，内核才能获得子进程退出信息从而释放那个进程描述符, 或者忽略这个信号, 由init进程处理
注意：当我们在父进程中添加了signal(SIGCHLD,SIG_IGN)时，就不要调用waitpid函数去回收子进程了，否则会报错
### SIGSTOP/SIGCONT
暂停进程/恢复进程
一个进程收到SIGSTOP后会暂停执行，并屏蔽除SIGKILL外所有信号，在收到SIGCOUNT后，才会继续执行
#### SIGKILL
杀死进程
#### SIGTERM
程序结束（terminate）信号，软件终止信号。与SIGKILL不同的是该信号可以被阻塞和处理，通常用来要求程序自己正常退出
#### SIGSEGV
内存访问错误导致进程终止。（Segmentation fault）
#### SIGURG
在Linux环境下，内核通知应用程序带外数据到达主要有两种方法: 一种是：I/O复用技术，select等系统调用在接收到带外数据时将返回，并向应用程序报告socket上的异常事件，
另外一种方法就是：使用SIGURG信号。
### 与tty相关的信号
跟tty相关的信号都是可以捕获的，可以修改它的默认行
#### SIGTTIN/SIGTTOU
unix环境下，当一个进程以后台形式启动，但尝试去读写控制台终端时，将会触发 SIGTTIN（读） 和 SIGTTOU（写）信号量，
接着，进程将会暂停（linux默认），read/write将会返回错误。
这时，shell将会提醒用户切换此进程为前台进程，以便继续执行。后台切换至前台的命令。
父进程的标准3个fd链接到pts或者tty字符设备上, 后台进程fork出来继承了父进程的fd, 所以后台进程自身实现后台的时候会重定向三个标准流(0, 1, 2), 防止读写.
**实际测试中发现后台进程读stdin会接收一个SIGTTIN信号, 写未触发任何信号**
#### SIGHUP
session leader进程退出后,如sshd会关闭ptmx, tty驱动会给所有session进程组进程发送一个SIGHUP信号,
此信号默认导致进程退出, 所以守护进程会调用setsid重新生成新session,
nohup原理就是屏蔽了这个信号, 但是它没有fork子进程退出父进程, shell仍然wait等待子进程退出, 所以需要&来后台运行
#### SIGINT
终止进程。通常用户使用 Ctrl + C, tty会发出终止信号给当前前端进程
#### SIGTSTP
终端输入CTRL+Z时，tty收到后就会发送SIGTSTP给前端进程组，其默认行为是将前端进程组放到后端，并且暂停进程组里所有进程的执行。
