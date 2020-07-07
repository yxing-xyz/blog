---
title: "Keyboard Mapping"
date: 2017-11-09T19:54:44+08:00
description: "Everyone has their own keyboard mapping"
categories:
  - "Linux"
  - "Windows"
tags:
  - "Configure"
# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "Everyone has their own keyboard mapping" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

## Windows
Download mapkeyboard, modify it by yourself, and then log out or restart it

## Linux
Linux has TTY terminal and desktop operation modes

### TTY

1.修改键位表

```
cd /usr/share/kbd/keymaps/i386/qwerty
# 解压键盘map.gz
gzip -d us.map.gz
# 编辑文件修改：
vim us.map
# Caps改为Ctrl
keycode  58 = Control
keycode  86 = less             greater          bar
keycode  97 = Control
Keycode  100 = Caps_Lock
# 重新压缩成.gz
gzip us.map
```

2.重新加载
仅限systemd引导的发行版,其余的如System V或者openrc引导的发行版请自行查询加载键盘代码
```
原理就是写入/etc/vconsole.conf文件内容KEYMAP=us
localectl set-keymap us 
```

### DESKTOP

#### 发行版中有 setxkbmap 命令

1、修改/usr/share/X11/xkb/symbols/pc

[pc文件](/archlinux/usr/share/X11/xkb/symbols/pc "pc文件")

在 xkb_symbols "pc105"最后面增加以下内容，然后重启即可

```
    replace key <CAPS> { [ Control_L ] };
    modifier_map Control { <CAPS> };
    replace key <RALT> { [ Caps_Lock ] };
    modifier_map Lock { <RALT> };
```

2、在~/.xinitrc exec 启动桌面之前或者.xprofile 写入

```
sudo setxkbmap  -option ctrl:swapcaps
```

#### 发行版中有 xmodmap 命令

1.在用户目录~中创建.Xmodmap 文件写入以下内容

```
   remove Lock = Caps_Lock
   remove Control = Control_L
   remove mod1 = Alt_R

   keysym Caps_Lock = Control_L
   keysym Alt_R = Caps_Lock

   add Lock = Caps_Lock
   add Control = Control_L
   add mod1 = Alt_R
```

2. 在用户目录~中添加.xprofile 或者.xinitrc 写入以下内容

```
/bin/bash -c "sleep 10; /usr/bin/xmodmap /home/用户名/.Xmodmap"
# sleep 10是等待x窗口完全启动，不然的话命令不生效
```

#### GNOME 中的 DCONF

dconf 也能修改，这里不做过多的介绍

|          Option |             Description |
| --------------: | ----------------------: |
|     ctrl:nocaps |       Caps Lock as ctrl |
| ctrl:lctrl meta |       Left Ctrl as Meta |
|   ctrl:swapcaps | Swap Ctrl and Caps Lock |
|    ctrl:ac ctrl |          At Left of 'A' |
|    ctrl:aa ctrl |          At bottom left |
| ctrl:rctrl ralt | Right Ctrl as Right Alt |
| ctrl:menu rctrl |      Menu as Right Ctrl |
| ctrl: ctrl ralt | Right Alt as Right Ctrl |

```
dconf write /org/gnome/desktop/input-sources/xkb-options \
"['esperanto:qwerty','ctrl:swapcaps']"
```
