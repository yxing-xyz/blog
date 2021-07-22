---
title: "Data Type"
date: 2018-06-18T15:20:41+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "Syntax"
  - "C"
  - "Golang"
  - "JavaScript"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
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

算术运算符: + - * / % ++ --
关系运算符: == != > < >= <=
逻辑运算符: && || !
位运算符: & | ^ << >>
赋值运算符: = += -= *= /= %= &= |= ^= <<= >>=
条件运算符(三目运算符): ? :
逗号运算符: 用于把若干表达式组合成一个表达式(，)
指针运算符: 用于取内容(*)和取地址(&)二种运算。
字节数运算符: sizeof
特殊运算符: (), [], ->, .
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

算术运算符: + - * / % ++ --
关系运算符: == != > < >= <=
逻辑运算符: && || !
位运算符: & | ^ << >>
赋值运算符: = += -= *= /= %= &= |= ^= <<= >>=
指针运算符: &(取值符), *(指针变量)
优先级     运算符
 7      ^ !
 6      * / % << >> & &^
 5      + - | ^
 4      == != < <= >= >
 3      <-
 2      &&
 1      ||
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
