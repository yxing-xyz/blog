---
title: "Golang Note"
date: 2020-08-05T23:08:00+08:00
description: "Golang knowledge points"
categories:
  - "Programming"
tags:
  - "Syntax"
  - "Golang"
# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "Golang knowledge points" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

## Golang 知识点

- **全局变量只能用 var 定义可以省略类型,不能用短命名法**

- **全局变量类似 C 语言宏定义没有开辟空间不能取址只能数字型(除了 uintptr)、string、bool**

- **type 新类型 类型这种方式可以挂方法,type 别名 = 也类似宏定义,不能在包外挂方法,这是和type类型的区别, 可以通过类型转换新类型和旧类型**

- **两个接口拥有相同的方法列表，方法次序可以不同，那么他们就是等价可以相互赋值，接口 A 是接口 B 的子级，B 可以赋值给 A**

- **类型实现接口如果方法接受者是指针,那么接口变量只能是存储这个类型的指针**

- **main 函数不能带参数，不能有返回值，且必须在 main 包中**

- **if语句块会遮挡外部定义的变量如命名返回值,导致bug所以变量尽量定义到外面**

- **结构体实现接口函数就实现了接口**

- **包中可以包含多个 init 函数，先执行导入包的 init 函数，然后 main 包 init，然后 main 函数**

- **for 循环不支持逗号隔开赋值，只支持平行赋值**

- **for range和闭包和协程很容易出错因为使用副本和指向地址没改变**

- **switch 的 case 条件中能出现多个结果选项，case 只有明确 fallthrough 才自动执行下一个且不经过 case 的判断，fallthrough 不能在代码中间，如果 switch 不为空则 case 只能比较相等，如果 switch 为空则 case 能写条件判断**

- **数字、字符串、布尔、数组、结构体是值类型，声明默认是值类型的初始值如 0、空字符串、nil**

- **slice、map、func、interface、point、chan 是引用类型，声明默认为 nil, 所以他们默认可以和 nil 比较，切忌 slice、map、func 不能比较编译不过，结构体和数组存储这些类型的也比较不了，赋值给空接口比较会 panic。**

- **比较类型要类型同样的才能继续比较值（我猜测引用类型比较类型相同然后比较指针值），否则编译不过，或者空接口放这些类型比较有的会抛 panic, slice、map、func 不能比较编译不过**

- **slice、map、chan 必须经过 make 初始化才能用，否则 nil 初始值就想当于 NULL 指针段内存错误**

- **当切片达到 cap 继续 append 会扩大 cap，小于 1024 会按照 2 倍，超过会 1.25 倍递增扩容**

- **append 新增超过 cap 返回扩容的新切片，否则返回旧切片， copy 切片两个切片长度最小为 n 复制右切片 n 长度的值到左边切片， 删除切片中头尾部直接重新切片赋值，中间用 append 或者 copy 来做**

- **函数返回值如果只有一个可以只写类型，如果多个必须括号包裹起来，如果返回值中有一命名返回值，其余参数必须全部命名**

- **给 nil chan 发送接收都会导致阻塞，可以用来阻塞 main 协程**

- **无缓冲的 chan 是同步，有缓冲事异步**

- **cap 函数适用数组、切片、通道**

- **select随机选取通道执行一次用来处理通道io，除了defalt其他都不要要读写chan, 多次外面加for**

- **delete函数用来删除map键值**

- **函数和成员和方法名大小写决定包外可见行类似public和private**

- **panic只能本协程栈层层返回,所以为了不让程序崩溃所有协程最好defer recover恢复panic, 多次panic只有最后一个panic被recover**

- **同一个目录中文件包名只能有一个**

- **defer是先进后出,后进先出执行在return之前**

- **除了nil任何值返回给接口那么这个接口不再是nil,即使是一个只声明未赋值或者未make初始化的引用类型,主要是go做了很多细节处理,和c不同**

- **switch type和.(类型)判断的变量只能是接口**

- **iota只能和const使用,每次const中间遇到iota都让他取当前const中的索引值从0开始**