---
title: "Data Type"
date: 2018-06-18T15:20:41+08:00
description: "The most basic of a programming language is data type"
categories:
  - "Programming"
tags:
  - "Syntax"
  - "C"
  - "Golang"
  - "JavaScript"

# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "The most basic of a programming language is data type" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

## C

```
                        整形: short int long

                数值类型:
                        浮点类型: float double

基本数据类型:

                字符类型: char
空类型(void)

指针类型

构造数据类型: 数组、结构体(struct)、共同体(union)、枚举(enum)
```

## GO

```
type byte uint8
type rune int32
基本类型:
        数值类型:     
                整数: Uintptr (U)Int (U)Int8 (U)Int16 (U)int32 (U)int64
                浮点数: Float32 Float64 
                复数： Complex64 Complex128
        字符串类型: String
        布尔类型: Bool

派生类型:
  值类型(初始值不为nil): Array、Struct
  引用类型(初始值为nil): Chan、Func、Interface、Map、Ptr、Slice
  
特殊类型:
  UnsafePointer
```

## Lua
```
number, string, boolean, nil, thread, table, userdata, function

number: 双精度浮点数
function: c或lua的函数
userdata: c的数据结构
```

## JavaScript

```
Number、String、Boolean、Null、Undefined、Symbol 引用类型(Object、Array、function)

Number双精度浮点数
```

## Python

```
Number(数字): int、float、bool、complex(复数)
String(字符串)
Tuple(元组)
List(列表)
Set(集合)
Dictionary(字典)
```

## Java
```
基本数据类型：byte、short、int、long、char、double、boolean
引用类型：类类型、接口类型、数组、null
```

## PHP
```
标量：整数、浮点数、布尔、字符串
复合：数组、对象
特殊：资源、null
```