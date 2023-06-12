---
title: "Keyboard Mapping"
date: 2017-11-09T19:54:44+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---


1. 被TTY接管键盘模式(桌面)
2. xorg接管键盘事件(服务器)
## TTY
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
仅限systemd引导的发行版
```bash
localectl set-keymap us
```
或者
```bash
echo 'KEYMAP=us' >> /etc/vconsole.conf
```
## X11
在/usr/share/X11/xkb/symbols有个pc文件可以修改映射。
### 查看keycode
```bash
xmodmap -pke
```
