---
title: "The difference between su and sudo in Linux"
date: 2020-08-07T21:27:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## su

su 是一种切换身份的命令操作,我猜测是解析参数验证用户名密码执行身份的默认 bash,。

-i 参数是使 shell 成登录 shell,这样就会切换工作目录到$HOME然后重新导入环境变量,换而言之没有这个选项将不会切换工作目录和环境变量,但是有少部分环境变量仍然覆盖如$HOME.

su 是 su root 简写,

su -是 su - root 的简写

```bash
su
su root

su -
su - root
```

## sudo

sudo本身并没有超级用户 root 的权限,它是通过本身命令在文件系统中有 SUID 这个值导致谁执行他都有 root 权限,但是它会校验执行 sudo 的用户是否/etc/sudoers 文件中

sudo最大的优点是使用用户的密码就能拥有root执行权限,最大的缺点就是可以用root执行权限修改掉root密码如sudo passwd root,所以拥有sudo的权限等于root用户了。所以我能想到的优点就是避免了使用root用户不小心删除别人的文件，因为必须第二次执行重新加sudo来执行，给了你思考的时间，让你不至于root一把唆如rm -rf /

sudo等于su root然后执行命令

sudo -i等于su root切换成root

```bash
# 基本使用
sudo ls

# 切换root等于su root
sudo -i

# 有点意思的用法
sudo su
sudo su root

sudo su -
sudo su - root
```
