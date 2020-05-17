---
title: "Linux Configuration"
date: 2018-09-01T09:51:36+08:00
description: "Linux Configuration"
categories:
  - "Linux"
tags:
  - "Configure"
# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "Linux Configuration" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

## Arch 安装

```bash
#!/usr/bin/env bash

# set -euxo pipefail
set -euo pipefail

# 获取archlinux源
# wget -O /etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/all/
# wget -O /etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/?country=CN

####################### U盘镜像系统
# 下载工具
pacman -S wget curl axel aria2 --needed --noconfirm
# 更改源
cp -rf ./etc/pacman.d /etc/
cp -rf ./etc/pacman.conf /etc/
# 更新源
pacman -Ssy
# 安装archlinux基本包
pacstrap -i /mnt base base-devel
# 保存新系统分区表到/mnt/etc/fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

######################## 切换到新系统
# 切换
arch-chroot /mnt /bin/bash

# 添加用户
useradd -g wheel yx
printf "yx\nyx\n" | passwd yx > /dev/null 2>&1

# 下载工具
pacman -S wget curl axel aria2 --needed --noconfirm
# 更改源
cp -rf ./etc/pacman.d /etc/
cp -rf ./etc/pacman.conf /etc/

# 生成本地化信息
# 下载语言包
echo "zh_CN.UTF-8 UTF-8
en_US.UTF-8 UTF-8
" >>/etc/locale.gen
locale-gen
# echo "LANG=zh_CN.UTF-8" >>/etc/locale.conf
localectl set-locale LANG=zh_CN.utf8

# 时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 默认为 UTC 时间，如需设置为本地时间，请执行：
# hwclock --systohc --localtime
hwclock --systohc
mkinitcpio -p linux

# mbr grub引导
# 使用eth0网卡
sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet net.ifnames=0 biosdevname=0"/g' /etc/default/grub
pacman -S grub os-prober --needed --noconfirm
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# 自启动网卡
# ip link
# echo "请输入网卡名:"
# read ip_link
# systemctl enable dhcpcd@"$ip_link".service
systemctl enable dhcpcd

# 导入CPG key
pacman -S archlinux-keyring --needed --noconfirm
pacman -S archlinuxcn-keyring --needed --noconfirm

# 安装 yay
pacman -Syu yay --needed --noconfirm
yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
su yx -c 'yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save'

# 降级软件
pacman -S downgrade --needed --noconfirm
# Arch安装脚本
pacman -S arch-install-scripts --needed --noconfirm

# 安装显卡驱动
echo -n "请选择显卡类型（1.Intel, 2.Nvidia, 3.ATI, 4.AMD, 5.通用):"
read video
case "$video" in
1) pacman -S xf86-video-intel --needed --noconfirm ;;
2) pacman -S xf86-video-nouveau --needed --noconfirm ;;
3) pacman -S xf86-video-ati --needed --noconfirm ;;
4) pacman -S xf86-video-amdgpu --needed --noconfirm ;;
5) pacman -S xf86-video-vesa --needed --noconfirm ;;
esac

# 安装图形界面
pacman -S xorg-server xorg-xinit --needed --noconfirm

# KDE
#pacman -S plasma-meta konsole dolphin sddm --needed --noconfirm
#systemctl enable sddm

# cinnamon桌面
pacman -S cinnamon cinnamon-translations --needed --noconfirm


# 重启
exit
umount -R /mnt
reboot
```

## Arch 初始化

```bash
#!/usr/bin/env bash
set -euo pipefail

################ 研发 ##############
# 常用开发工具
pacman -S yasm gcc cmake nginx php php-apache composer jdk8 gradle maven nodejs npm yarn git tig svn python python-pip --needed --noconfirm --force
# 编辑
pacman -S emacs vim visual-studio-code-bin intellij-idea-ultimate-edition --needed --noconfirm --force
# nodejs应用进程管理器
pacman -S pm2 --needed --noconfirm --force
# 打印进程调用
pacman -S strace --needed --noconfirm --force
# 数据库命令行
yay -S mycli pgcli-git litecli --needed --noconfirm --force
# 手册
yay -S cheat-git tldr --needed --noconfirm --force
# 代码行数统计
pacman -S loc --needed --noconfirm --force
# shell脚本检查
pacman -S shellcheck --needed --noconfirm --force
# SSR
yay -S shadowsocksr --needed --noconfirm --force

############# 虚拟机相关 ##############
# 远程桌面: rdesktop -f 222.240.148.238:50010 -u administrator -p hngat2015 -a 32 -r clipboard:PRIMARYCLIPBOARD -r disk:h=/home/yx/projects/PQTelWVMP/PQTelVMPDA/app
pacman -S rdesktop --needed --noconfirm --force


############## 资源监控 ###############
# 硬件信息lshw lscpu lsblk lspci 模块 lsmod 模块信息modinfo
pacman -S lshw hardinfo --needed --noconfirm --force
# 系统信息
pacman -S neofetch --needed --noconfirm --force
# 实时查看网络、cpu、内存、磁盘等多功能实时监控, sysstat多单功能瞬时查看
pacman -S nmon dstat sysstat --needed --noconfirm --force
# 资源监控
pacman -S glances htop --needed --noconfirm --force
# 实时cpu监控
pacman -S s-tui --needed --noconfirm --force
# 进程磁盘读写监控iotop  磁盘和cpu负载iostat
pacman -S iotop --needed --noconfirm --force
# 查看磁盘使用
pacman -S ncdu --needed --noconfirm --force
# 网卡网速监控
pacman -S bmon bwm-ng nload iftop --needed --noconfirm --force
# 进程统计网络带宽
pacman -S nethogs --needed --noconfirm --force



##################  网络工具 ##############
# ifconfig、route在net-tools包中，nslookup、dig在dnsutils包中，ftp、telnet等在inetutils包中，ip命令在iproute2包中
pacman -S net-tools dnsutils inetutils iproute2 --needed --noconfirm
# 端口扫描namp、端口netcat、端口数据发送端口转发socat、http测试 nmap -Pn -v -A www.baidu.com  -p 0-10000
pacman -S nmap openbsd-netcat socat httpie --needed --noconfirm --force
# 测试本机发送tcp/udp最大带宽 时延 丢包, 路由测试工具mtr
pacman -S iperf mtr --needed --noconfirm --force
# 抓包
pacman -S iptraf-ng wireshark-qt wireshark-gtk ngrep --needed --noconfirm --force
# 内网穿透
pacman -S frp localtunnel ngrok --needed --noconfirm --force



################### 终端神器 #####################
# shell
pacman -S zsh --needed --noconfirm --force
# 终端复用
pacman -S tmux --needed --noconfirm --force
# 终端文件管理ranger
pacman -S ranger vifm nnn mc --needed --noconfirm --force # 终端文件管理
pacman -S atool --needed --noconfirm --force              # 用于预览各种压缩文件
pacman -S highlight --needed --noconfirm --force          # 用于在预览代码，支持多色彩高亮显示代码
pacman -S w3m --needed --noconfirm --force                # lynx, w3m 或 elinks：这三个东西都是命令行下的网页浏览器，都用于htm
pacman -S poppler --needed --noconfirm --force            # PDF阅读
pacman -S mediainfo --needed --noconfirm --force          # mediainfo 或 perl-image-exiftool ： audio/video
# 命令模糊搜索 fzf
pacman -S fzf --needed --noconfirm --force
# 目录文件搜索 fd
pacman -S fd --needed --noconfirm --force
# 文件内容搜索 ag ripgrep ack
pacman -S the_silver_searcher ripgrep ack --needed --noconfirm --force
# 彩色cat、彩色日志、彩色diff
pacman -S bat ccze diff-so-fancy colordiff --noconfirm --needed --force
# 终端表格、文本三神器
pacman -S awk sed grep --needed --noconfirm --force

# SSH
pacman -S mosh --needed --noconfirm --force
# 文件传输 rsync
pacman -S rsync   --needed --noconfirm --force

# 查看进度
pacman -S progress --needed --noconfirm --force
# 目录树形结构
pacman -S tree --needed --noconfirm --force
# 回收站
pacman -S trash-cli --needed --noconfirm --force

# 文件读写测试
pacman -S fio --needed --noconfirm --force

# 监听文件变更运行命令
pacman -S entr --needed --noconfirm --force
# 试运行
yay -S python-maybe --needed --noconfirm --force
# 终端音乐
pacman -S cmus --needed --noconfirm --force
# 终端二维码 echo "http://123.com" | qrencode -o - -t UTF8
pacman -S qrencode --needed --noconfirm --force
# youtube、youku下载工具、BT下载工具
pacman -S transmission-cli you-get youtube-dl --needed --noconfirm --force

# 制作ISO镜像
pacman -S xorriso mkisolinux --needed --noconfirm --force # xorriso -as mkisofs -R -J -T -v --no-emul-boot --boot-load-size 4 --boot-info-table -V "CentOS" -c isolinux/boot.cat -b isolinux/isolinux.bin -o ./boot.iso ./centos7-cdrom/
# 解压软件
pacman -S p7zip file-roller unrar rar zip unzip-natspec --needed --noconfirm
# 支持NTFS文件系统
pacman -S ntfs-3g dosfstools --needed --noconfirm
# 挂载远程ssh目录
pacman -S sshfs --needed --noconfirm --force


# HTTP代理
pacman -S squid --needed --noconfirm --force
# http共享
sudo npm install -g serve

# 邮件伪造
pacman -S swaks --needed --noconfirm --force
# 暴力破解工具
pacman -S hydra hashcat fcrackzip --needed --noconfirm --force

# cpu限速
pacman -S cpulimit --needed --noconfirm --force
# 网络限速
yay -S wondershaper-git --needed --noconfirm --force

# 翻译
pacman -S translate-shell  --needed --noconfirm --force
# 翻译
sudo npm install -g fanyi  # 依赖 festival festvox-kallpc16k

# 图片处理
pacman -S  imagemagick --needed --noconfirm --force
# 优化svg
sudo npm install -g svgo

# 终端GIF,终端录屏
pacman -S asciinema --needed --noconfirm --force
# 终端GIF
yay -S ttygif ttyrec --needed --noconfirm --force

# 黑客帝国
pacman -S cmatrix --needed --noconfirm --force
# 假装很忙
yay -S genact hollywood --needed --noconfirm --force
# 电路图
yay -S bash-pipes --needed --noconfirm --force

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

# 开源CAD
pacman -S kicad --needed --noconfirm --force



############### GUI  ###########
# 输入法
pacman -S fcitx-sogoupinyin --needed --noconfirm
# 安装浏览器
pacman -S chromium firefox firefox-i18n-zh-cn --needed --noconfirm
# 字体
pacman -S ttf-dejavu wqy-zenhei wqy-microhei powerline2 awesome-terminal-fonts nerd-fonts-complete adobe-source-han-sans-cn-fonts  otf-font-awesome ttf-font-awesome --needed --noconfirm
# 字体
yay -S consolas-font ttf-consolas-powerline ttf-consolas-with-powerline ttf-consolas-with-yahei-powerline-git --needed --noconfirm --force
# Telegram
pacman -S telegram-desktop --needed --noconfirm --force
# 影音播放
pacman -S vlc kodi ffmpeg mplayer smplayer --needed --noconfirm --force
# 下载
pacman -S qbittorrent amule --needed --noconfirm --force
# FTP
pacman -S filezilla --needed --noconfirm --force
# 截图
pacman -S maim --needed --noconfirm --force      #截图
# 图像预览
pacman -S feh --noconfirm --force --needed
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
```

## Ubuntu 初始化

```bash
#!/usr/bin/env bash
# 换源
sed -i 's#^[^\#].*\.edu.cn#deb http://mirrors.163.com#g' /etc/apt/sources.list
apt update
apt upgrade
apt autoremove

apt install ubuntu-make
add-apt-repository ppa:ubuntu-desktop/ubuntu-make

apt install -y gnome-tweaks
apt install -y gnome-tweak-tool gnome-shell-extension-dashtodock

apt install -y fonts-wqy-microhei fonts-wqy-zenhei xfonts-wqy
apt install -y git zsh tmux chromium-browser emacs vim

apt install -y php python3 python gcc gdb g++ golang nodejs npm
apt install -y net-tools curl

############ VSCode ###############
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt -y install apt-transport-https
sudo apt -y update
sudo apt -y install code # or code-insiders
sudo xdg-mime default code.desktop text/plain
sudo update-alternatives --set editor /usr/bin/code

# RUSTUP
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
############ Other ################
# brook
snap install brook
```

## 用户初始化

```bash
#!/bin/env sh

# 改变SHELL
# su yx -c "echo 'yx' | chsh -s /bin/zsh"
chsh -s /bin/zsh

go env -w GOPROXY=https://goproxy.cn,direct

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

npm config set registry https://registry.npm.taobao.org

echo "[source.crates-io]
registry = \"https://github.com/rust-lang/crates.io-index\"
replace-with = 'ustc'
[source.ustc]
registry = \"git://mirrors.ustc.edu.cn/crates.io-index\"" > $HOME/.cargo/config
```

## Arch 配置文件

- etc
  - pacman.d
    - <a href="/archlinux/etc/pacman.d/mirrorlist" target="_blank">mirrorlist</a>
  - <a href="/archlinux/etc/locale.conf" target="_blank">locale.conf</a>
  - <a href="/archlinux/etc/locale.gen" target="_blank">locale.gen</a>
  - <a href="/archlinux/etc/makepkg.conf" target="_blank">makepkg.conf</a>
  - <a href="/archlinux/etc/pacman.conf" target="_blank">pacman.conf</a>
  - <a href="/archlinux/etc/vconsole.conf" target="_blank">vconsole.conf</a>
- usr
  - share
    - X11
      - xkb
        - symbols
          - <a href="/archlinux/usr/share/X11/xkb/symbols/pc" target="_blank">pc</a>
