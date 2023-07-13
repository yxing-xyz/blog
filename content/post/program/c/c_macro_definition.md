---
title: "C宏定义"
date: 2020-05-14T20:06:39+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "编程"
tags:
  - "编程"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
常用的宏操作
<!--more-->
## 获取结构体成员偏移字节数
You only need to include <stddef.h> to use offset
or write the following code
```c
#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
```
## 获取结构体对齐字节
```c
#define ALIGN(size, boundary) (((size) + ((boundary)-1)) & ~((boundary)-1))
#define ALIGN_DEFAULT(size) ALIGN(size, 8)
```
## <stdbool.h>
You can use Booleans as long as you include <stdbool.h>
```c
#ifndef _STDBOOL
#define _STDBOOL

#define __bool_true_false_are_defined 1

#ifndef __cplusplus

#define bool  _Bool
#define false 0
#define true  1

#endif /* __cplusplus */

#endif /* _STDBOOL */
```

## 动态库导出函数
安卓、Linux
1. 默认不到出函数
GCC编译器参数隐藏所有符号`-fvisibility=hidden`

Win:
1. 默认不导出函数 TODO
2. 使用的地方倒入方法
在对应的使用该方法的地方需要显示的导入函数才可以使用`__declspec(dllimport)`

IOS:
1. 默认不导出函数 TODO


导出函数
```c
#if defined(WIN32)
#define X_EXPORT __declspec(dllexport)
#else
#define X_EXPORT __attribute__((visibility("default")))
#endif
```
