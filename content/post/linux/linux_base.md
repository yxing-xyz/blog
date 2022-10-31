---
title: "Linux基础"
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

## whatis

whatis 命令是用于查询一个命令的功能，并将查询结果打印到终端上。 whatis 命令在 man -w 显示的文件中查找 command 参数指定的命令、系统调用、库函数或特殊文件名。whatis 命令显示手册部分的页眉行，还能能看到该命令的其他章节的内容。whatis 命令等同于使用 man -f 命令。

## whereis

whereis 省略参数，则显示所有文件；
-b 定位可执行文件
-m 定位帮助文件
-s 定位源码文件
-u 搜索默认路径下除可执行文件、源代码、帮助文件意外的其他文件
-B 指定搜索执行文件路径
-M 指定搜索帮助文件路径
-S 指定搜索源代码文件路径

## man

-a 在所有的 man 帮助手册中搜索
-f 等价于 whatis 指令，显示给定关键字的简短描述信息；
-P 指定内容时使用分页程序
-M 指定 man 手册搜索的路径
-k 指令/文件：模糊查询，用此参数将列出整个 man page 中个所查内容相关的内容，即它将同时查找指令/文件名，和相应的说明的内容，只要包含有所查找的内容就会被列出。

### man 的章节号

| 章节号 | 含义                                          |
| ------ | --------------------------------------------- |
| 1      | 用户在 shell 环境中可以实现的命令或可执行文件 |
| 2      | 系统内核可调用的函数和工具                    |
| 3      | 一些常见的函数与函数库，大部分为 C 的函数库   |
| 4      | 一些常见的函数与函数库，大部分为 C 的函数库   |
| 5      | 配置文件或者某些文件的格式                    |
| 6      | 游戏                                          |
| 7      | 惯例与协议，例如 Linux 文件系统、网络协议等   |
| 8      | 系统管理员可使用的管理命令                    |
| 9      | 跟 kernel 有关的文件                          |
| 10     | 开发者章节                                    |

## 文件/目录
特殊权限可以通过数字快捷赋予, 但是只能通过chmod ug-st字符串的方式移除
文件类型7种ls -al可以查看, 目录和文件最多255个ASCII字符,因为结构体dirent.d_name里是char [256], 需要\0占用字符串结束符
linux可执行文件还可以设置capabilities权限
判断一个文件是否硬链接ls -l 第二行数字标识硬链接次数, 目录的可执行权限x标识是否能cd进入到目录
| 符号 | 含义         |
| ---- | ------------ |
| -    | 文件/硬链接  |
| d    | 目录         |
| b    | 块设备文件   |
| c    | 字符设备文件 |
| l    | 软链接       |
| p    | 管道文件     |
| s    | 套接字文件   |


### 普通权限
三位标识, 每位由r, w, x组合,共有 6中, 可以用数字标识777 = r+w+x
mask是标识当前进程的默认权限, unmask是屏蔽权限, 创建文件默认的mask是666, 创建的目录的默认的mask是777, unmask默认重父进程继承来, 默认值022, 
所以touch默认创建一个644权限, mkdir默认创建一个755权限
### SetUID
* 只有可执行文件才能设定 SetUID 权限，对目录设定 SUID，是无效的。
* 用户要对该文件拥有 x（执行）权限。
* 用户在执行该文件时，会以文件所有者的身份执行。
* SetUID 权限只在文件执行过程中有效，一旦执行完毕，身份的切换也随之消失。
* getuid获取的是执行用户的ID
* geteuid获取的是可执行用户的ID或者文件的拥有者ID(设置了SetUID位)
### SetGID
文件: 
用户需要对此可执行文件有 x 权限；
用户在执行具有 SGID 权限的可执行文件时，用户的群组身份会变为文件所属群组；
SGID 权限赋予用户改变组身份的效果，只在可执行文件运行过程中有效；

目录:
当一个目录被赋予 SGID 权限后，进入此目录的普通用户，其有效群组会变为该目录的所属组，会就使得用户在创建文件（或目录）时，该文件（或目录）的所属组将不再是用户的所属组，而使用的是目录的所属组。
也就是说，只有当普通用户对具有 SGID 权限的目录有 rwx 权限时，SGID 的功能才能完全发挥。比如说，如果用户对该目录仅有 rx 权限，则用户进入此目录后，
虽然其有效群组变为此目录的所属组，但由于没有 x 权限，用户无法在目录中创建文件或目录，SGID 权限也就无法发挥它的作用。
### Stick BIT
SBIT 权限仅对目录有效，一旦目录设定了 SBIT 权限，则用户在此目录下创建的文件或目录，就只有自己和 root 才有权利修改或删除该文件。

## 信号
### SIGPIPE
对端close socket后收到本机的tcp报文, 会回复一个RST报文, 内核在产生SIGPIPE信号给本机进程导致进程退出, 所以tcp程序一般都屏蔽此信号
```c
// 为了避免进程退出，可以捕获 SIGPIPE 信号，或者忽略它，给他设置 SIG_IGN 信号处理函数。
signal(SIGPIPE, SIG_IGN);
```

### SIGCHLD
在父进程fork()之前安装SIGCHLD信号处理函数，并在此handler函数中调用waitpid()等待子进程结束，
这样，内核才能获得子进程退出信息从而释放那个进程描述符, 或者忽略这个信号, 由init进程处理
注意：当我们在父进程中添加了signal(SIGCHLD,SIG_IGN)时，就不要调用waitpid函数去回收子进程了，否则会报错
### SIGSTOP
暂停进程
### SIGCONT
恢复进程
#### SIGKILL
杀死进程
#### SIGTERM
程序结束（terminate）信号，软件终止信号。与SIGKILL不同的是该信号可以被阻塞和处理，通常用来要求程序自己正常退出
#### SIGSEGV
内存访问错误导致进程终止。（Segmentation fault）
### 与tty相关的信号
跟tty相关的信号都是可以捕获的，可以修改它的默认行
#### SIGTTIN/SIGTTOU
unix环境下，当一个进程以后台形式启动，但尝试去读写控制台终端时，将会触发 SIGTTIN（读） 和 SIGTTOU（写）信号量，
接着，进程将会暂停（linux默认），read/write将会返回错误。
这时，shell将会提醒用户切换此进程为前台进程，以便继续执行。后台切换至前台的命令。
父进程的标准3个fd链接到pts或者tty字符设备上, 后台进程fork出来继承了父进程的fd, 所以后台进程自身实现后台的时候会重定向三个标准流(0, 1, 2), 防止读写.

#### SIGHUP
session leader进程退出后,如sshd会关闭ptmx, tty驱动会给所有session进程组进程发送一个SIGHUP信号, 
此信号默认导致进程退出, 所以守护进程会调用setsid重新生成新session, 
nohup原理就是屏蔽了这个信号, 但是它没有fork子进程退出父进程, tty的前端进程组仍然被绑定, shell仍然wait等待子进程退出, 所以需要&来后台运行
#### SIGINT
终止进程。通常用户使用 Ctrl + C, tty会发出终止信号给当前前端进程
#### SIGTSTP
终端输入CTRL+Z时，tty收到后就会发送SIGTSTP给前端进程组，其默认行为是将前端进程组放到后端，并且暂停进程组里所有进程的执行。

## 守护进程
具体步骤:
1. 先屏蔽SIGCHLD信号避免僵尸进程产生, fork子进程, 父进程退出, 因为shell正在wait 父进程.
2. 子进程执行setsid(), 产生新的sessionid, 防止shell退出(shell是一个session leader)导致整个session进程收到信号退出
3. 子进程chdir("/"), umask(0), close(0,1,2)等不需要的fd. 防止umount等提示进程占用, umask最大权限, 节省系统fd资源
## session
session就是一组进程的集合，session id就是这个session中leader的进程ID。
session的主要特点是当session的leader退出后，session中的所有其它进程将会收到SIGHUP信号，其默认行为是终止进程，
即session的leader退出后，session中的其它进程也会退出。
如果session和tty关联的话，它们之间只能一一对应，一个tty只能属于一个session，一个session只能打开一个tty。当然session也可以不和任何tty关联。
### session的创建
session可以在任何时候创建，调用setsid函数即可，session中的第一个进程即为这个session的leader，leader是不能变的.

## 进程组
进程组（process group）也是一组进程的集合，进程组id就是这个进程组中leader的进程ID。
进程组的主要特点是可以以进程组为单位通过函数killpg发送信号
### 进程组的创建
进程组主要用在shell里面，shell负责进程组的管理，包括创建、销毁等。（这里shell就是session的leader）
* 对大部分进程来说，它自己就是进程组的leader，并且进程组里面就只有它自己一个进程
* shell里面执行类似ls|more这样的以管道连接起来的命令时，两个进程就属于同一个进程组，ls是进程组的leader。
* shell里面启动一个进程后，一般都会将该进程放到一个单独的进程组，然后该进程fork的所有进程都会属于该进程组，比如多进程的程序，它的所有进程都会属于同一个进程组，当在shell里面按下CTRL+C时，该程序的所有进程都会收到SIGINT而退出。
### 前台进程组
占有控制终端的进程，其它称为后台进程, 一个会话可以有多个后台进程组，但只能有一个前台进程组, shell负责更新tty中的前端进程组, tty将输入输出绑定到前端进程组
### 后台进程组
非前台进程组即为后台进程组

## 僵尸进程/孤儿进程
> 僵尸进程：一个子进程在父进程还没有调用wait()方法或者waitpid()方法的情况下退出，这个子进程就是僵尸进程；
> 孤儿进程：一个父进程退出，它的一个或多个子进程还在运行，子进程将成为孤儿进程，孤儿进程将被init进程所收养；
僵尸进程将会导致资源浪费，而孤儿进程则不会。
避免僵尸进程的方法:
1. fork两次. 让子进程快速结束, 孙子进程被init进程接收, 达到父进程永远在后面结束且执行了waitpid().
2. 父进程屏蔽SIGCHLD信号由init进程释放进程描述符.
## Shell
### 管道运算符|
管道运算符只能传递stdout输出, 如果stderr如果要管道传输需要重定向2>&1

### jobs
ps 列出系统中正在运行的进程
kill 发送信号给一个或多个进程（经常用来杀死一个进程）
jobs 列出属于当前用户的进程
bg 将进程搬到后台运行（Background）
fg 将进程搬到前台运行（Foreground
### top命令
进程的运行状态
```txt
D = uninterruptible sleep
I = idle
R = running
S = sleeping
T = stopped by job control signal
t = stopped by debugger during trace
Z = zombie
```

