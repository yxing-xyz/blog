---
title: "Linux基础"
date: 2021-09-10T22:27:00+08:00
lastmod: 2023-06-12T17:33:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
## whatis
whatis 命令是用于查询一个命令的功能，并将查询结果打印到终端上。

whatis 命令在 man -w 显示的文件中查找 command 参数指定的命令、系统调用、库函数或特殊文件名。

whatis 命令显示手册部分的页眉行，还能能看到该命令的其他章节的内容。

whatis 命令等同于使用 man -f 命令。
## whereis
whereis 省略参数，则显示所有文件；
* -b 定位可执行文件
* -m 定位帮助文件
* -s 定位源码文件
* -u 搜索默认路径下除可执行文件、源代码、帮助文件意外的其他文件
* -B 指定搜索执行文件路径
* -M 指定搜索帮助文件路径
* -S 指定搜索源代码文件路径
## man
* -a 在所有的 man 帮助手册中搜索
* -f 等价于 whatis 指令，显示给定关键字的简短描述信息；
* -P 指定内容时使用分页程序
* -M 指定 man 手册搜索的路径
* -k 指令/文件：模糊查询，用此参数将列出整个 man page 中个所查内容相关的内容，即它将同时查找指令/文件名，和相应的说明的内容，只要包含有所查找的内容就会被列出。
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
## find
### 找可执行文件
```bash
find `pwd` -type f -executable -print
```
## top
### 进程的运行状态
```txt
D = uninterruptible sleep
I = idle
R = running
S = sleeping
T = stopped by job control signal
t = stopped by debugger during trace
Z = zombie
```a
## mount
* mount目录自身, 好处:
1. 它允许为该特定目录树指定某些额外的挂载选项, -o ro设置为只读。
2. 硬链接无法链接这个目录.
```bash
mount --bind /data/test /data/test
```
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
也就是说，只有当普通用户对具有 SGID 权限的目录有 rwx 权限时，SGID 的功能才能完全发挥。比如说，如果用户对该目录仅有 r 权限，则用户进入此目录后，
虽然其有效群组变为此目录的所属组，但由于没有 x 权限，用户无法在目录中创建文件或目录，SGID 权限也就无法发挥它的作用。
### Stick BIT
SBIT 权限仅对目录有效，一旦目录设定了 SBIT 权限，则用户在此目录下创建的文件或目录，就只有自己和 root 才有权利修改或删除该文件。
### chattr
可以锁定文件不能删除,可以写入
```bash
chattr +a myfile
```
### du和df空间不一致
1. rm删除文件inode节点被进程打开内核不会释放空间.
2. mount挂载非空目录隐藏了原磁盘导致du并没有统计这部分空间
### tmpfs加速
```bash
# 挂载
mount -t tmpfs -o size=4G tmpfs ./node_modules
# 拷贝到内存中
cp -RT ./.vscode/node_modules ./node_modules
yarn build
# 接触挂载
umount ./node_modules
```
### 分区扩容
```bash
growpart /dev/vdb 1
e2fsck -f /dev/vdb1
resize2fs /dev/vdb1
```
### 制作rootfs
```bash
mkfs -t ext4 livecd.img
mount -o loop livecd.img /mnt
cp -ax /{bin,etc,lib,lib64,opt,sbin,usr,var} /mnt
mkdir -p /mnt/{proc,sys,dev,run,tmp,home,media}

# 打压缩包
# tar --xattrs-include='*.*' --numeric-owner -czvf ./rootfs.targ.gz /mnt
```
### merge-usr
```bash
\cp -rv --preserve=all --remove-destination bin/* usr/bin
\cp -rv --preserve=all --remove-destination lib/* usr/lib
\cp -rv --preserve=all --remove-destination lib64/* usr/lib64
\cp -rv --preserve=all --remove-destination sbin/* usr/bin

rm -rf bin lib lib64 sbin
ln -s usr/bin bin
ln -s usr/lib lib
ln -s usr/lib64 lib64
ln -s usr/bin sbin
```
### parted分区
```bash
##
paretd
mklabel gpt
mkparted ESP 1M 100M
mkparted Linux 100M 100G
exit
```
## 添加用户和修改密码
```bash
useradd -m -G wheel -s /bin/zsh x
printf "123456\n123456\n" | passwd x > /dev/null 2>&1
```
## 时区
```bash
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```
## 同步时间
```bash
## 同步时间
ntpdate ntp.aliyun.com
hwclock -w
# 设置系统时间同步到bios中
hwclock --systohc --localtime # hwclock --systohc
```
## 多语言环境
```bash
echo "zh_CN.UTF-8 UTF-8
en_US.UTF-8 UTF-8
" >>/etc/locale.gen
locale-gen
localectl set-locale LANG=zh_CN.UTF-8 # echo "LANG=zh_CN.UTF-8" >>/etc/locale.conf
```
## WIFI wpa_cli
```bash
# 创建网络返回网络ID
wpa_cli -i wlan0 add_network
# 设置ssid
wpa_cli -i wlan0 set_network 0 ssid '"B701"'
# 设置psk
wpa_cli -i wlan0 set_network 0 psk '"nalzj4ka"'
# 启用网络
wpa_cli -i wlan0 enable_network 0
# 保存网络
wpa_cli -i wlan0 save_config
```
## 电池
```bash
# 电池
upower -i `upower -e | grep 'BAT'` # 查看电池信息
acpi -v # 查看电池信息
acpi -a # 充电状态
acpi -t # 电池温度
```