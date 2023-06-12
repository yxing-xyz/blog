---
title: "Gentoo"
date: 2023-06-12T15:51:00+08:00
lastmod: 2023-06-12T15:51:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## install gentoo
下载livecd进入, 或者使用docker进入
### 1. parted分区
略
### 2. 格式化分区, 挂载分区, 解压stage3
```bash
mkfs.vfat /dev/vda1
mkfs.ext4 /dev/vda2
mount /dev/vda2 /mnt/gentoo
mount /dev/vda1 /mnt/gentoo/boot/ESP
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/
mount --types proc /proc /mnt/gentoo/proc
# umount -R 可以递归解除挂载
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"
```
### 3. portage使用内存文件系统加速
`提高SSD的寿命`
```bash
# 方法一指定特殊包不使用tmpfs
mkdir -p /etc/portage/env
echo 'PORTAGE_TMPDIR = "/var/tmp/notmpfs"' > /etc/portage/env/notmpfs.conf
mkdir -p /var/tmp/notmpfs
chown portage:portage /var/tmp/notmpfs
chmod 775 /var/tmp/notmpfs
echo 'www-client/chromium notmpfs.conf' >> /etc/portage/package.env

# 方法二增加tmpfs内存或者交换分区
# mount -o remount,size=N /var/tmp/portage

# 方法三 指定交换文件
# 内存不够解决方法2
## 创建交换文件
dd if=/dev/zero of=/var/cache/swap bs=1024M count=8
chmod 600 /var/cache/swap
mkswap /var/cache/swap
swapon /var/cache/swap

swapoff /var/cache/swap
```
### 4. gentoo linux内核
```bash
# 生成默认内核
emerge --ask sys-kernel/linux-firmware  sys-firmware/intel-microcode
emerge --ask sys-kernel/gentoo-sources
emerge --ask sys-kernel/dracut
make ARCH=x86_64 defconfig
make -j17
make modules_install
make install
dracut --early-microcode --kver=6.1.12-gentoo

# 安装grub
grub-install --target=arm64-efi --boot-directory=/boot/ --efi-directory=/boot/ESP --bootloader-id=grub
# 生成的grub.cfg必须放在上面一条命令安装的grub目录中
grub-mkconfig -o /boot/grub/grub.cfg
```
### 5. systemd初始化设置
```bash
# 初始化语言，键盘
systemd-firstboot --prompt --setup-machine-id
# 提供了一个"预设"文件，可用于启用一组合理的默认服务。
systemctl preset-all
```


## emerge
```bash
emerge --ask --update --deep --newuse @world
# 深度清理
emerge --ask --depclean
# 修改USE, 编译所有依赖的包
emerge --update --changed-use @world
# 删除包，如果是顶层包，merge树会移除包，中间包只是移除顶层依赖关系
emerge --ask -c sudo
# 指定版本
emerge "=dev-lang/go-1.19.5"
# 重新构建包管理树
emerge @preserved-rebuild
# 重新安装包，不使用顶层依赖
emerge --oneshot sudo
# 查看已安安装包
eix-installed -a
# 查看依赖的顶层包
eix --color -c --world

# 查看包依赖
equery g bo
# 查看包被依赖
equery d go
# 查看哪些包使用这个标志
equery h llvm
# 查看文件属于哪个包
equery b ls
# 查看包有哪些文件
equery f glibc
# 清除源文件/var/cache/distfiles
eclean-dist --deep
# 清除二进制包/var/cache/binpkgs
eclean-pkg --deep
# 生成分发二进制安装包
quickpkg "*/*"
# 重建二进制包索引
emaint binhost --fix
# 重新安装所有包
emerge -e @world
revdep-rebuild
emerge --ignore-default-opts -va1 $(qdepends -CQqqF'%{CAT}/%{PN}:%{SLOT}' '^dev-libs/boost:0/1.70.0')
# 配置文件更新
etc-update
# 配置文件合并
dispatch-cofn
```