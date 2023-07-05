---
title: "Mac"
date: 2023-07-05T13:00:00+08:00
lastmod: 2023-07-05T13:00:00+08:00
draft: false
categories:
  - "杂项"
tags:
  - "杂项"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 关闭密码策略
2. finder默认显示所有文件
3. 卸载Java
4. 更改自带SSH端口
5. brew tap
6. brew package
<!--more-->

## 关闭密码策略
```bash
pwpolicy -clearaccountpolicies
```
## finder默认显示所有文件
```bash
defaults write com.apple.finder AppleShowAllFiles -bool true
```
## 卸载Java
```bash
## 卸载java
sudo rm -fr /Library/Internet Plug-Ins/JavaAppletPlugin.plugin
sudo rm -fr /Library/PreferencesPanes/JavaControlPanel.prefPane
sudo rm -fr ~/Library/Application?``Support/Oracle/Java
```
## 更改自带SSH端口
1. 编辑配置文件
```bash
# 编辑服务文件，修改ssh端口
sudo vim /etc/services
# 重新生成配置文件
sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
```
2. 重启服务
![mac](/blog/img/mac_start_ssh.png)
## brew tap
```bash
## brew降级
brew tap-new $USER/local-tap
brew extract --version='7.0.0' qemu $USER/local-tap
brew install qemu@7.0.0
## 删除tap
brew untap $USER/local-tap

## brew手动下载依赖包
cd $(brew --cache)/downloads
```
## brew package
```txt
bat
ca-certificates
curl
easy-rsa
fzf
go
htop
hugo
iredis
k9s
lazygit
lsd
lua
mtr
mycli
ripgrep
rustup-init
sd
sqlite
subversion
tmux
trash-cli
wget
zsh
zstd
nmap
fd
git-delta
tree
git
lrzsz
zssh
trzsz-go
zoxide
neofetch
p7zip
baidupcs-go
pyenv
zellij
qemu
```
```txt
adrive
emacs
font-noto-sans-cjk-sc
google-chrome
obs
tencent-meeting
wireshark
alacritty
flameshot
font-noto-serif-cjk-sc
inkscape
qbittorrent
thunder
wpsoffice-cn
calibre
font-ubuntu-mono-nerd-font
iterm2
rawtherapee
visual-studio-code
dbeaver-community
font-code-new-roman-nerd-font
gifcapture
karabiner-elements
raycast
vlc
docker
font-iosevka-nerd-font
gimp
krita
switchhosts
wechat
douyin
font-noto-color-emoji
goland
neteasemusic
tabby
wechatwork
dbeaver-community
```

## 系统设置
![mac](/blog/img/mac/1.png)
![mac](/blog/img/mac/2.png)
![mac](/blog/img/mac/3.png)
![mac](/blog/img/mac/4.png)
![mac](/blog/img/mac/5.png)
![mac](/blog/img/mac/6.png)
![mac](/blog/img/mac/7.png)
![mac](/blog/img/mac/8.png)
![mac](/blog/img/mac/9.png)
![mac](/blog/img/mac/10.png)
![mac](/blog/img/mac/11.png)
![mac](/blog/img/mac/12.png)
![mac](/blog/img/mac/13.png)
![mac](/blog/img/mac/lock_screen.png)
![mac](/blog/img/mac/15.png)
![mac](/blog/img/mac/16.png)
![mac](/blog/img/mac/17.png)
![mac](/blog/img/mac/18.png)
![mac](/blog/img/mac/19.png)
![mac](/blog/img/mac/20.png)
![mac](/blog/img/mac/mouse.png)
![mac](/blog/img/mac/21.png)
![mac](/blog/img/mac/22.png)
![mac](/blog/img/mac/23.png)
