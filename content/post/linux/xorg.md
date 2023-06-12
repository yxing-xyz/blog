---
title: "Xorg"
date: 2018-09-01T09:51:36+08:00
lastmod: 2023-06-12T16:52:00+08:00
draft: false
categories:
  - "Linux"
tags:
  - "Linux"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## 输入设备
```bash
# 输入设备
xinput # 查看输入设备列表
xinput disable 15 # 禁用设备
xinput enable  15 # 启动设备
xinput list-props 15 # 查看设备属性
xinput set-prop 15 298 -0.5 # 设置设备属性
```
## 显示器
```bash
# 关闭显示器电源
xset dpms force off

# 10分钟后关闭显示器电源
xset dpms 600 600 600
```
## 键盘频率
```bash
# 设置键盘频率
xset rate 200 30
```
## 查看x窗口资源属性
```bash
xprop
```
## 默认应用
```bash
# 设置默认浏览器
xdg-settings set default-web-browser google-chrome.desktop
```
## 录屏
```bash
ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 output.mp4
# 录制音频和视频
ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 -f alsa -ac 2 -i hw:0 output.mp4
# 无损录制
ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 -c:v libx264  -qp 0 -preset ultrafast output.mkv

```
## 摄像头
```bash
# 查看摄像头设备
v4l2-ctl --list-devices

# 播放摄像头
mpv av://v4l2:/dev/video0 --profile=low-latency --untimed
```
## 投影
```bash
# 第一条命令：查看已连接的可视化设备
xrandr | grep -v disconnected | grep connected

# 第二条命令：新建分屏（例如：我的主屏幕是eDP-1，新建屏是HDMI-2）--mode 1920x1080
xrandr --output HDMI-2 --auto --right-of eDP-1
xrandr --output HDMI-2 --auto --same-as eDP-1
xrandr --output HDMI-2 --auto --left-of eDP-1

# 第三条命令：关闭分屏
xrandr --output HDMI-2 --off

使用扩展模式
设置指定显示器为主屏幕：xrandr --output eDP-1 --primary
设置多个显示器之间的相对位置：xrandr --output eDP-1 --left-of HDMI-2
```