---
title: "LSP"
date: 2023-05-07T21:14:00+08:00
lastmod: 2023-05-07T21:14:00+08:00
draft: false
categories:
  - "Configure"
tags:
  - "Linux"
  - "Windows"
  - "Mac"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---


## C/C++
1. 安装clangd
2. 安装对应的前端编辑器插件如vscode clangd插件
3. cmake生成或者用bear转Makefile到compile_commands.json
```bash
# 生成makefile
./auto/configure --with-stream --with-file-aio --with-http_ssl_module --with-http_v2_module --with-debug --prefix=/tmp/nginx
# bear将makefile转compile_commands.json
bear -- make -j8
```
