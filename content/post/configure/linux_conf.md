---
title: "Linux Configuration"
date: 2018-09-01T09:51:36+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Configure"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## Arch 软件包
```bash
#!/usr/bin/env bash
# set -euxo pipefail
set -o errexit
set -o nounset
set -o pipefail
################################
# 安装图形界面                     剪切板 窗口特效 合并X11配置
pacman -S xorg-server xorg-xinit xclip picom xorg-xrdb  xorg-xinput xsel--needed --noconfirm
# awesome
pacman -S awesome --needed --noconfirm
# 清除密码 gnome-keyring-daemon -r -d
pacman -S gnome-keyring

# 导入CPG key/
pacman -S archlinux-keyring --needed --noconfirm
pacman -S archlinuxcn-keyring --needed --noconfirm
# 安装 yay       降级
pacman -Syu yay downgrade --needed --noconfirm

# 常用开发工具
pacman -S yasm gcc cmake nginx php php-apache composer jdk8 gradle maven nodejs npm yarn git tig svn python python-pip go go-tools --needed --noconfirm --force
# 编辑
pacman -S emacs vim visual-studio-code-bin intellij-idea-ultimate-edition --needed --noconfirm --force
# nodejs应用进程管理器
pacman -S pm2 --needed --noconfirm --force
# 打印进程调用
pacman -S strace --needed --noconfirm --force
# 数据库命令行
yay -S iredis mycli pgcli-git litecli --needed --noconfirm --force
# 手册
yay -S cheat-git tldr --needed --noconfirm --force
# 代码行数统计
pacman -S cloc --needed --noconfirm --force
# shell脚本检查
pacman -S shellcheck --needed --noconfirm --force

# k8s
pacman -S k9s helm tekton-cli --needed --noconfirm --force

############# 虚拟机相关 ##############
# rdesktop -f 222.240.148.238:50010 -u administrator -p hngat2015 -a 32 -r clipboard:PRIMARYCLIPBOARD -r disk:h=/home/x
# x0vncserver -display :0 -passwordfile ~/.vnc/passwd
# xfreerdp /bpp:32 /gfx +aero +fonts /d:192.168.44.118 /u:x /p:x /v:192.168.44.118
#         启动vnc服务端 win远程桌面客户端
pacman -S tigervnc freerdp --needed --noconfirm --force


############## 资源监控 ###############
# 硬件信息lshw lscpu lsblk lspci 模块 lsmod 模块信息modinfo dmi信息解码 smartmontools磁盘信息
pacman -S lshw hardinfo dmidecode --needed smartmontools --noconfirm --force
# 系统信息
pacman -S neofetch --needed --noconfirm --force
# 实时查看网络、cpu、内存、磁盘等多功能实时监控, sysstat多单功能瞬时查看
pacman -S nmon dstat sysstat --needed --noconfirm --force
# 资源监控
pacman -S glances htop --needed --noconfirm --force
# 实时cpu监控
pacman -S s-tui --needed --noconfirm --force


##################  net工具 ##############
# ifconfig、route在net-tools包中，nslookup、dig在dnsutils包中，ftp、telnet等在inetutils包中，ip命令在iproute2包中
pacman -S net-tools dnsutils inetutils iproute2 bridge-utils --needed --noconfirm
# 网卡网速监控 conntrack-tools查看连接跟踪, ipvsadm查看ipvs
pacman -S bmon bwm-ng nload iftop conntrack-tools ipvsadm --needed --noconfirm --force
# 进程统计网络带宽
pacman -S nethogs --needed --noconfirm --force
# 查看ip连接 端口扫描namp、端口netcat、端口数据发送端口转发socat、http测试 nmap -Pn -v -A www.baidu.com  -p 0-10000
pacman -S iptstate nmap openbsd-netcat socat httpie --needed --noconfirm --force
# 测试本机发送tcp/udp最大带宽 时延 丢包, 路由测试工具mtr
pacman -S iperf mtr --needed --noconfirm --force
# 抓包
pacman -S iptraf-ng wireshark-qt wireshark-gtk ngrep --needed --noconfirm --force
# 内网穿透
# sshuttle --dns -vr root@114.215.181.234 192.168.0.0/16 --ssh-cmd 'ssh -i /home/x/workspace/juewei/k8s/cert/品牌中心密钥对.key'
pacman -S frp localtunnel sshuttle --needed --noconfirm --force
# wifi
pacman -S networkmanager --needed --noconfirm --force
nmcli  dev wifi list
nmcli device wifi connect "x" password "qwer1234"
nmcli connection import type openvpn file file.ovpn
################## 磁盘和文件系统工具 ###############
# 进程磁盘读写监控iotop  磁盘和cpu负载iostat
pacman -S iotop --needed --noconfirm --force
# 查看磁盘使用
pacman -S ncdu --needed --noconfirm --force
# 文件系统扩容 resize2fs fsck检查文件系统错误
pacman -S e2fsprogs --needed --noconfirm --force
# 文件读写测试
pacman -S fio --needed --noconfirm --force

################### 终端神器 #####################
# shell
pacman -S zsh --needed --noconfirm --force
# 终端复用
pacman -S tmux --needed --noconfirm --force
# 终端文件管理
pacman -S ranger vifm nnn mc --needed --noconfirm --force # 终端文件管理
pacman -S atool --needed --noconfirm --force              # 用于预览各种压缩文件
pacman -S highlight --needed --noconfirm --force          # 用于在预览代码，支持多色彩高亮显示代码
pacman -S w3m --needed --noconfirm --force                # lynx, w3m 或 elinks：这三个东西都是命令行下的网页浏览器，都用于htm
pacman -S poppler poppler-data --needed --noconfirm --force            # PDF阅读
pacman -S mediainfo --needed --noconfirm --force          # mediainfo 或 perl-image-exiftool ： audio/video
# nnn
sudo pacman -S nnn atool libarchive trash-cli sshfs rclone fuse2 xdg-utils

# 命令模糊搜索 fzf
pacman -S fzf --needed --noconfirm --force
# 目录文件搜索 fd
pacman -S fd --needed --noconfirm --force
# 文件内容搜索 rg ag ack
pacman -S ripgrep the_silver_searcher ack --needed --noconfirm --force
# 彩色cat、彩色日志、彩色diff
pacman -S bat ccze diff-so-fancy colordiff --noconfirm --needed --force
# 终端表格、文本三神器
pacman -S awk sed grep --needed --noconfirm --force
# TERM=screen-256color sshpass -p 'fm09j#Ojiogj32i' ssh -p 2222 -o ServerAliveInterval=60 root@127.0.0.1
pacman -S sshpass mosh --needed --noconfirm --force
# 查看进度
pacman -S progress --needed --noconfirm --force
# 目录树形结构
pacman -S exa tree --needed --noconfirm --force
# 回收站
pacman -S trash-cli --needed --noconfirm --force
# 解压软件
pacman -S p7zip-natspec rar zip unzip-natspec --needed --noconfirm
# 支持NTFS文件系统
pacman -S ntfs-3g dosfstools --needed --noconfirm
# 挂载远程ssh目录
pacman -S sshfs --needed --noconfirm --force
# 终端音乐
pacman -S cmus --needed --noconfirm --force
# 终端二维码 echo "http://baidu.com" | qrencode -o - -t UTF8
pacman -S qrencode --needed --noconfirm --force
# 局域网的ip二维码上下传文件
yay -S qrcp --needed --noconfirm --force
# HTTP代理
pacman -S squid --needed --noconfirm --force
# http共享
sudo npm install -g serve
# youtube、youku下载工具、BT下载工具
pacman -S wget curl axel aria2 transmission-cli you-get youtube-dl --needed --noconfirm --force
# 翻译
pacman -S translate-shell  --needed --noconfirm --force


# 图片处理
pacman -S  imagemagick --needed --noconfirm --force
# 终端GIF,终端录屏
pacman -S asciinema --needed --noconfirm --force
# 文本转图表
pacman -S graphviz --needed --noconfirm --force
# 文档转换
pacman -S pandoc --needed --noconfirm --force
# 处理 Excel 或 CSV ，csvkit 提供了 in2csv，csvcut，csvjoin，csvgrep 等方便易用的工具
yay -S csvkit --needed --noconfirm --force
# json文件处理以及格式化显示
pacman -S jq --needed --noconfirm --force
# 终端艺术字体
pacman -S figlet --needed --noconfirm --force

# 计算工具
pacman -S datamash --needed --noconfirm --force
# 监听文件变更运行命令
pacman -S entr --needed --noconfirm --force
# 文件传输 rsync
pacman -S rsync  --needed --noconfirm --force


# cpu限速
pacman -S cpulimit --needed --noconfirm --force
# 网络限速
yay -S wondershaper-git --needed --noconfirm --force
# 邮件伪造
pacman -S swaks --needed --noconfirm --force
# 暴力破解工具
pacman -S hydra hashcat fcrackzip --needed --noconfirm --force
# 制作ISO镜像
# xorriso -as mkisofs -R -J -T -v --no-emul-boot --boot-load-size 4 --boot-info-table -V "CentOS" -c isolinux/boot.cat -b isolinux/isolinux.bin -o ./boot.iso ./centos7-cdrom/
pacman -S xorriso mkisolinux --needed --noconfirm --force

############### GUI  ###########
# 启动工具
pacman -S rofi --needed --noconfirm --force
# 截图
pacman -S scrot flamescrot maim --needed --noconfirm --force
# 图像预览
pacman -S feh --noconfirm --force --needed
# proxy
pacman -S qv2ray v2ray  proxychains --needed --noconfirm --force
# 输入法
pacman -S librime ibus-rime --needed --noconfirm
# 字体
pacman -S nerd-fonts-complete otf-font-awesome ttf-dejavu powerline-fonts noto-fonts-cjk --needed --noconfirm
# wqy
pacman -S `sudo pacman -Ssq 'wqy-*'` --needed --noconfirm
# adobe
pacman -S `sudo pacman -Ssq 'adobe-source-*'` --needed --noconfirm
# 安装浏览器
pacman -S chromium firefox firefox-i18n-zh-cn pepper-flash --needed --noconfirm
# Telegram
pacman -S telegram-desktop --needed --noconfirm --force
# 影音播放
pacman -S vlc mpd mpv kodi ffmpeg mplayer smplayer --needed --noconfirm --force
# 下载
pacman -S qbittorrent amule --needed --noconfirm --force
# FTP
pacman -S filezilla --needed --noconfirm --force
# 截图转Latex语法
yay -S mathpix-snipping-tool --needed --noconfirm --force
# 图像编辑
pacman -S krita gimp --needed --noconfirm --force         #图像编辑
pacman -S inkscape --needed --noconfirm --force           #矢量图形编辑软件
pacman -S rawtherapee --needed --noconfirm --force        #跨平台图片处理
# 绘图
pacman -S mypaint --needed --noconfirm --force            #绘画涂鸦软件
pacman -S blender --needed --noconfirm --force            #3D工具
# 文档查看
pacman -S evince foxitreader --needed --noconfirm --force # PDF
pacman -S kchmviewer --needed --noconfirm --force         # CHM
pacman -S calibre --needed --noconfirm --force            # 图书转换器
# 开源CAD
pacman -S kicad --needed --noconfirm --force
# 蓝牙
pacman -S bluez bluez-utils pulseaudio-bluetooth --needed --noconfirm --force
systemctl start bluetooth.service
systemctl enable bluetooth.service
```
## ArchLinux
```bash
# 安装archlinux基本包
pacstrap -i /mnt base base-devel linux linux-firmware linux-headers
# 保存新系统分区表到/mnt/etc/fstab
genfstab -U -p /mnt >> /mnt/etc/fstab
# arch-chroot切换
arch-chroot /mnt /bin/bash

# 构建包,在PKGBUILD目录下执行
makepkg
# 安装构建包
pacman -U ./构建包名
```

## Linux
```bash
# 时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 设置系统时间同步到bios中
hwclock --systohc --localtime # hwclock --systohc
# locale
echo "zh_CN.UTF-8 UTF-8
en_US.UTF-8 UTF-8
" >>/etc/locale.gen
locale-gen
localectl set-locale LANG=zh_CN.UTF-8 # echo "LANG=zh_CN.UTF-8" >>/etc/locale.conf

# grub
grub-install --target=x86_64-efi --boot-directory=/boot/ESP/EFI/ --efi-directory=/boot/ESP --bootloader-id=grub
grub-mkconfig -o /boot/ESP/EFI/grub/grub.cfg

# 添加用户
useradd -g wheel yx
printf "x\nx\n" | passwd x > /dev/null 2>&1
## grub
```

## Linux Xorg
```bash
# 查看设备的sysfs属性
udevadm info -q all -a /dev/input/event13

# 输入设备
xinput # 查看输入设备列表
xinput disable 15 # 禁用设备
xinput enable  15 # 启动设备
xinput list-props 15 # 查看设备属性
xinput set-prop 15 298 -0.5 # 设置设备属性

# 关闭显示器电源
xset dpms force off

# 电池
upower -i `upower -e | grep 'BAT'` # 查看电池信息
acpi -v # 查看电池信息
acpi -a # 充电状态
acpi -t # 电池温度

# 设置键盘频率
xset rate 200 30

# 查看x窗口资源属性
xprop

# 设置默认浏览器
xdg-settings set default-web-browser google-chrome.desktop
```
