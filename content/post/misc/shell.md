---
title: "Shell杂项"
date: 2021-06-16T20:00:00+08:00
lastmod: 2023-06-16T14:54:00+08:00
draft: false
categories:
  - "杂项"
tags:
  - "杂项"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
* zsh
1. bindkey
2. zle
3. git仓库关闭zsh插件读取git信息导致zsh卡顿
<!--more-->

## zsh
### bindkey
```bash
# 现有键映射名称的列表
bindkey -l
# 显示该键映射的全部映射
bindkey -M emacs
# 设置zsh的键映射
bindkey -e emacs
bindkey -e '^?' delete-char
# 清空所有键映射
bindkey -d
```

### zle
```bash
## zle组件调用
zle backward-delete-char
```
### git仓库关闭zsh插件读取git信息导致zsh卡顿
```bash
# 设置oh-my-zsh不读取文件变化信息
git config --add oh-my-zsh.hide-dirty 1
# 设置oh-my-zsh不读取任何git信息
git config --add oh-my-zsh.hide-status 1
```