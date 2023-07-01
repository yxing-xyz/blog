---
title: "npm"
date: 2023-07-01T10:42:00+08:00
lastmod: 2023-07-01T10:42:00+08:00
draft: false
categories:
  - "编程"
tags:
  - "编程"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

1. NPM
<!--more-->
## 常用命令
```bash
# 下载项目依赖
npm install
# 查看全局包已安装,去除依赖--depth 0
npm ls -g
# 查看项目已安装,去除依赖--depth 0 加上环境--dev --prod
npm ls
```

## npm-check-updates
检查package.json可升级的包
```bash
# 安装
sudo npm install -g npm-check-updates

# 检查可升级的包
npm-check-updates
ncu

# 全部升级
ncu -u
```