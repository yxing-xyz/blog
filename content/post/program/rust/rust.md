---
title: "Rust"
date: 2023-06-14T17:54:00+08:00
lastmod: 2023-06-14T17:54:00+08:00
draft: false
categories:
  - "编程"
tags:
  - "编程"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

1. Go的区别和联系
<!--more-->

## 基本难点
### 指针类型
| 类型名   | 简介                                                      |
| -------- | --------------------------------------------------------- |
| Box<T>   | 指向类型T的，具有所有权指针，有权释放内存                 |
| &T       | 指向类型T的借用指针，也称引用，无权释放内存，无权写入数据 |
| &mut T   | 指向类型T的mut形借用指针，无权释放内存，有权写入数据      |
| *const T | 指向类型T的只读裸指针，没有生命周期信息，无权写入数据     |
| *mut T   | 指向类型T的可读写裸指针，没有生命周期信息，有权写入数据   |
在标准库还有一种封装起来可以当智能指针使用的类型，叫”智能指针“）

| 类型名   | 简介                                                                   |
| -------- | ---------------------------------------------------------------------- |
| Rc<T>    | 指向类型T的引用计数指针，共享所有权，线程不安全                        |
| Arc<T>   | 只想类型T的原子型引用计数指针，共享所有权，线程安全                    |
| Cow<',T> | Copy-on-writer，写时复制指针。可能是借用指针，也可能是具有所有权的指针 |



## 区别和联系
### Go的区别和联系
#### 区别
1. Rust末尾需要加上分号, 变量类型前需要有冒号(:)
2. Rust变量屏蔽
3. Rust全局变量需要static关键字声明且必须初始化, 带有mut可变的全局变量读写还需要加上unsafe关键字
4. Rust Format格式，Rust支持命名参数
5. Rust语法支持迭代器模式统一访问方
6. Rust最后一行语句可以不用写分号(;)
7. Rust返回值只有一行不用写return
#### 联系
1. tuple sturct实现go的type新类型， type alias等于go的type别名
2. loop等于for不带参数
