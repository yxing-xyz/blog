---
title: "Keyboard Mapping"
date: 2017-11-09T19:54:44+08:00
description: "Everyone has their own keyboard mapping"
categories:
  - "Configure"
tags:
  - "Linux"
  - "Windows"
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
下载  mapkeyboard软件修改然后重启机器



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

### X11
在/usr/share/X11/xkb/symbols有个pc文件可以修改映射，网上说可以使用用localectl设置keymap也是us，可惜x11没用这个所以还是直接修改pc文件吧

