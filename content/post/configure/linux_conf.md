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
pacman -S xorg-server xorg-xinit xclip picom xorg-xrdb  xorg-xinput xsel --needed --noconfirm --overwrite '*'
# awesome
pacman -S awesome --needed --noconfirm --overwrite '*'

# 清除密码 gnome-keyring-daemon -r -d
pacman -S gnome-keyring --needed --noconfirm --overwrite '*'

# 导入CPG key/
pacman -S archlinux-keyring --needed --noconfirm --overwrite '*'
pacman -S archlinuxcn-keyring --needed --noconfirm --overwrite '*'
# 安装 yay       降级 
pacman -Syu yay downgrade --needed --noconfirm --overwrite '*'

# 常用开发工具
pacman -S yasm gcc cmake nginx php php-apache composer jdk8 gradle maven nodejs npm yarn git tig svn python python-pip go go-tools --needed --noconfirm --overwrite '*'
# 编辑
pacman -S emacs vim visual-studio-code-bin intellij-idea-ultimate-edition --needed --noconfirm --overwrite '*'
# nodejs应用进程管理器
pacman -S pm2 --needed --noconfirm --overwrite '*'
# 打印进程调用
pacman -S strace --needed --noconfirm --overwrite '*'
# 数据库命令行
yay -S iredis mycli pgcli-git litecli --needed --noconfirm --overwrite '*'
# 手册
yay -S cheat-git tldr man-pages man-pages-zh_cn--needed --noconfirm --overwrite '*'
# 代码行数统计
pacman -S cloc --needed --noconfirm --overwrite '*'
# shell脚本检查
pacman -S shellcheck --needed --noconfirm --overwrite '*'

# k8s
pacman -S k9s helm tekton-cli --needed --noconfirm --overwrite '*'

############# 虚拟机相关 ##############
# rdesktop -f 222.240.148.238:50010 -u administrator -p hngat2015 -a 32 -r clipboard:PRIMARYCLIPBOARD -r disk:h=/home/x
# x0vncserver -display :0 -passwordfile ~/.vnc/passwd
# xfreerdp /bpp:32 /gfx +aero +fonts /d:192.168.44.118 /u:x /p:x /v:192.168.44.118
#         启动vnc服务端 win远程桌面客户端
pacman -S tigervnc freerdp --needed --noconfirm --overwrite '*'


############## 资源监控 ###############
# 硬件信息lshw lscpu lsblk lspci 模块 lsmod 模块信息modinfo dmi信息解码 smartmontools磁盘信息
pacman -S lshw hardinfo dmidecode --needed smartmontools --noconfirm --overwrite '*'
# 系统信息
pacman -S neofetch --needed --noconfirm --overwrite '*'
# 实时查看网络、cpu、内存、磁盘等多功能实时监控, sysstat多单功能瞬时查看
pacman -S nmon dstat sysstat --needed --noconfirm --overwrite '*'
# 资源监控
pacman -S glances htop --needed --noconfirm --overwrite '*'
# 实时cpu监控
pacman -S s-tui --needed --noconfirm --overwrite '*'


##################  net工具 ##############
# ifconfig、route在net-tools包中，nslookup、dig在dnsutils包中，ftp、telnet等在inetutils包中，ip命令在iproute2包中
pacman -S net-tools dnsutils inetutils iproute2 bridge-utils --needed --noconfirm
# 网卡网速监控 conntrack-tools查看连接跟踪, ipvsadm查看ipvs aircrack-ng 网卡混合监听和破解wifi密码
pacman -S bmon bwm-ng nload iftop conntrack-tools ipvsadm aircrack-ng --needed --noconfirm --overwrite '*'
# 进程统计网络带宽
pacman -S nethogs --needed --noconfirm --overwrite '*'
# 查看ip连接 端口扫描namp、端口netcat、端口数据发送端口转发socat、http测试 nmap -Pn -v -A www.baidu.com  -p 0-10000
pacman -S iptstate nmap openbsd-netcat socat httpie --needed --noconfirm --overwrite '*'
# 测试本机发送tcp/udp最大带宽 时延 丢包, 路由测试工具mtr
pacman -S iperf mtr --needed --noconfirm --overwrite '*'
# 抓包
pacman -S iptraf-ng wireshark-qt wireshark-gtk ngrep --needed --noconfirm --overwrite '*'
# 内网穿透
# sshuttle --dns -vr root@114.215.181.234 192.168.0.0/16 --ssh-cmd 'ssh -i /home/x/workspace/juewei/k8s/cert/品牌中心密钥对.key'
pacman -S frp localtunnel sshuttle --needed --noconfirm --overwrite '*'
# 网络管理服务, 界面和插件
pacman -S networkmanager network-manager-applet networkmanager-openvpn networkmanager-strongswan --needed --noconfirm --overwrite '*'
nmcli  dev wifi list
nmcli device wifi connect "x" password "qwer1234"
nmcli connection import type openvpn file file.ovpn
################## 磁盘和文件系统工具 ###############
# 进程磁盘读写监控iotop  磁盘和cpu负载iostat
pacman -S iotop --needed --noconfirm --overwrite '*'
# 查看磁盘使用
pacman -S ncdu --needed --noconfirm --overwrite '*'
# 文件系统扩容 resize2fs fsck检查文件系统错误
pacman -S e2fsprogs --needed --noconfirm --overwrite '*'
# 文件读写测试
pacman -S fio --needed --noconfirm --overwrite '*'

################### 终端神器 #####################
# shell
pacman -S zsh --needed --noconfirm --overwrite '*'
# 终端复用
pacman -S tmux --needed --noconfirm --overwrite '*'
# 终端文件管理
pacman -S ranger vifm nnn mc --needed --noconfirm --overwrite '*' # 终端文件管理
pacman -S atool --needed --noconfirm --overwrite '*'              # 用于预览各种压缩文件
pacman -S highlight --needed --noconfirm --overwrite '*'          # 用于在预览代码，支持多色彩高亮显示代码
pacman -S w3m --needed --noconfirm --overwrite '*'                # lynx, w3m 或 elinks：这三个东西都是命令行下的网页浏览器，都用于htm
pacman -S poppler poppler-data --needed --noconfirm --overwrite '*'            # PDF阅读
pacman -S mediainfo --needed --noconfirm --overwrite '*'          # mediainfo 或 perl-image-exiftool ： audio/video
# nnn
sudo pacman -S nnn atool libarchive trash-cli sshfs rclone fuse2 xdg-utils

# 命令模糊搜索 fzf
pacman -S fzf --needed --noconfirm --overwrite '*'
# 目录文件搜索 fd
pacman -S fd --needed --noconfirm --overwrite '*'
# 文件内容搜索 rg ag ack
pacman -S ripgrep the_silver_searcher ack --needed --noconfirm --overwrite '*'
# 彩色cat、彩色日志、彩色diff
pacman -S bat ccze diff-so-fancy colordiff --noconfirm --needed --overwrite '*'
# 终端表格、文本三神器
pacman -S awk sed grep --needed --noconfirm --overwrite '*'
# TERM=screen-256color sshpass -p 'fm09j#Ojiogj32i' ssh -p 2222 -o ServerAliveInterval=60 root@127.0.0.1
pacman -S sshpass mosh --needed --noconfirm --overwrite '*'
# 查看进度
pacman -S progress --needed --noconfirm --overwrite '*'
# 目录树形结构
pacman -S exa tree --needed --noconfirm --overwrite '*'
# 回收站
pacman -S trash-cli --needed --noconfirm --overwrite '*'
# 解压软件
pacman -S p7zip-natspec rar zip unzip-natspec --needed --noconfirm
# 支持NTFS文件系统
pacman -S ntfs-3g dosfstools --needed --noconfirm
# 挂载远程ssh目录
pacman -S sshfs --needed --noconfirm --overwrite '*'
# 终端音乐
pacman -S cmus --needed --noconfirm --overwrite '*'
# 终端二维码 echo "http://baidu.com" | qrencode -o - -t UTF8
pacman -S qrencode --needed --noconfirm --overwrite '*'
# 局域网的ip二维码上下传文件
yay -S qrcp --needed --noconfirm --overwrite '*'
# HTTP代理
pacman -S squid --needed --noconfirm --overwrite '*'
# http共享
sudo npm install -g serve
# youtube、youku下载工具、BT下载工具
pacman -S wget curl axel aria2 transmission-cli you-get youtube-dl --needed --noconfirm --overwrite '*'
# 翻译
pacman -S translate-shell  --needed --noconfirm --overwrite '*'


# 图片处理
pacman -S  imagemagick --needed --noconfirm --overwrite '*'
# 终端GIF,终端录屏
pacman -S asciinema --needed --noconfirm --overwrite '*'
# 文本转图表
pacman -S graphviz --needed --noconfirm --overwrite '*'
# 文档转换
pacman -S pandoc --needed --noconfirm --overwrite '*'
# 处理 Excel 或 CSV ，csvkit 提供了 in2csv，csvcut，csvjoin，csvgrep 等方便易用的工具
yay -S csvkit --needed --noconfirm --overwrite '*'
# json文件处理以及格式化显示
pacman -S jq --needed --noconfirm --overwrite '*'
# 终端艺术字体
pacman -S figlet --needed --noconfirm --overwrite '*'

# 计算工具
pacman -S datamash --needed --noconfirm --overwrite '*'
# 监听文件变更运行命令
pacman -S entr --needed --noconfirm --overwrite '*'
# 文件传输 rsync
pacman -S rsync  --needed --noconfirm --overwrite '*'


# cpu限速
pacman -S cpulimit --needed --noconfirm --overwrite '*'
# 网络限速
yay -S wondershaper-git --needed --noconfirm --overwrite '*'
# 邮件伪造
pacman -S swaks --needed --noconfirm --overwrite '*'
# 暴力破解工具
pacman -S hydra hashcat fcrackzip --needed --noconfirm --overwrite '*'
# 制作ISO镜像
# xorriso -as mkisofs -R -J -T -v --no-emul-boot --boot-load-size 4 --boot-info-table -V "CentOS" -c isolinux/boot.cat -b isolinux/isolinux.bin -o ./boot.iso ./centos7-cdrom/
pacman -S xorriso mkisolinux --needed --noconfirm --overwrite '*'

############### GUI  ###########
# 启动工具
pacman -S rofi --needed --noconfirm --overwrite '*'
# 截图
pacman -S scrot flameshot maim --needed --noconfirm --overwrite '*'
# 图像预览
pacman -S feh --noconfirm --overwrite '*' --needed
# proxy
pacman -S qv2ray v2ray  proxychains --needed --noconfirm --overwrite '*'
# 输入法
pacman -S librime ibus-rime --needed --noconfirm --overwrite '*'
# 字体
pacman -S nerd-fonts-complete otf-font-awesome ttf-dejavu powerline-fonts noto-fonts-cjk --needed --noconfirm --overwrite '*'
# wqy
pacman -S `sudo pacman -Ssq 'wqy-*'` --needed --noconfirm --overwrite '*'
# adobe
pacman -S `sudo pacman -Ssq 'adobe-source-*'` --needed --noconfirm --overwrite '*'
# 安装浏览器
pacman -S chromium firefox firefox-i18n-zh-cn pepper-flash --needed --noconfirm
# Telegram
pacman -S telegram-desktop --needed --noconfirm --overwrite '*'
# 影音播放
pacman -S vlc mpd mpv kodi ffmpeg mplayer smplayer --needed --noconfirm --overwrite '*'
# 下载
pacman -S qbittorrent amule --needed --noconfirm --overwrite '*'
# FTP
pacman -S filezilla --needed --noconfirm --overwrite '*'
# 截图转Latex语法
yay -S mathpix-snipping-tool --needed --noconfirm --overwrite '*'
# 图像编辑
pacman -S krita gimp --needed --noconfirm --overwrite '*'         #图像编辑
pacman -S inkscape --needed --noconfirm --overwrite '*'           #矢量图形编辑软件
pacman -S rawtherapee --needed --noconfirm --overwrite '*'        #跨平台图片处理
# 绘图
pacman -S mypaint --needed --noconfirm --overwrite '*'            #绘画涂鸦软件
pacman -S blender --needed --noconfirm --overwrite '*'            #3D工具
# 文档查看
pacman -S evince foxitreader --needed --noconfirm --overwrite '*' # PDF
pacman -S kchmviewer --needed --noconfirm --overwrite '*'         # CHM
pacman -S calibre --needed --noconfirm --overwrite '*'            # 图书转换器
# 开源CAD
pacman -S kicad --needed --noconfirm --overwrite '*'
# 蓝牙
pacman -S bluez bluez-utils pulseaudio-bluetooth --needed --noconfirm --overwrite '*'
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
## 录屏
```bash
ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 output.mp4
# 录制音频和视频
ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 -f alsa -ac 2 -i hw:0 output.mkv
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

## zsh
```bash
# 设置oh-my-zsh不读取文件变化信息
git config --add oh-my-zsh.hide-dirty 1
# 设置oh-my-zsh不读取任何git信息
git config --add oh-my-zsh.hide-status 1
```