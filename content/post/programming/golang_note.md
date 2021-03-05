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

- **声明变量 var 可以不用初始化,var 声明初始化可以省略类型,简短声明左边必须有一个未声明变量且右边必须初始化**

```go
var a, b, c int
var d = 1
d, e := 2, "213"
```

- **全局变量只能用 var 定义可以省略类型,不能用短命名法**
```go
var A int = 1
var B = 1 // 自动推断
```

- **常量不能重新赋值,不能调用函数因编译期确定,常量有无类型关联默认类型常量如常量字符串,常量 bool,常量数字,也可以带类型常量,带类型常量就不能赋值给别名类型赋值**

```go
const A = 1
const C int = 2
const B = test() // error, 常量是编译期确定
func test() int{
	return 1
}
func main() {
	A = 12313 // error, 常量不能赋值

	type MyInt int

	var b MyInt = A // ok, 因为A是无类型关联int类型
	var b MyInt = C // error报错因为,常量有类型,类型不一样不能赋值
}

```

- **同一个包里面函数名,接口名,结构体名,全局变量,全局常量不能重名**
```go
func A(){} // error
type A interface{} // error
type A struct{} // error
const A // error
var A int // errro
```

- **type 新类型 类型这种方式可以挂方法,type 别名 = 也类似宏定义,不能在包外挂方法,这是和 type 类型的区别, 可以通过类型转换新类型和旧类型**

- **两个接口拥有相同的方法列表，方法次序可以不同，那么他们就是等价可以相互赋值，接口 A 是接口 B 的子级，B 可以赋值给 A**

- **类型实现接口如果方法接受者是指针,那么接口变量只能是存储这个类型的指针**

- **main 函数不能带参数，不能有返回值，且必须在 main 包中**

- **if 语句块会遮挡外部定义的变量如命名返回值,导致 bug 所以变量尽量定义到外面**

- **结构体实现接口函数就实现了接口**

- **包中可以包含多个 init 函数，先执行导入包的 init 函数，然后 main 包 init，然后 main 函数**

- **for 循环不支持逗号隔开赋值，只支持平行赋值**

- **for range里面的闭包和协程很容易出错因为使用副本和指向地址没改变**

- **switch 的 case 条件中能出现多个结果选项，case 只有明确 fallthrough 才自动执行下一个且不经过 case 的判断，fallthrough 不能在代码中间，如果 switch 不为空则 case 只能比较相等，如果 switch 为空则 case 能写条件判断**

- **比较是同类型才能比较,数字、字符串、布尔、数组、结构体是值类型不能和nil比较，声明默认是值类型的初始值如 0、空字符串、false, 数组和结构体内部存储类型的初始值, Chan、Func、Interface、Map、Ptr、Slice是引用类型，声明默认为 nil, 所以可以和nil比较**

- **Func,Map,Slice不能和自身类型比较编译不过，结构体和数组存储这些类型的也编译不过, 用空接口强行比较运行会panic**

- **容量型派生类型Chan,Map,Slice必须经过 make 初始化才能用，否则 nil 初始值就想当于 NULL 指针段内存错误**

- **当切片达到cap容量时继续append 会扩大 cap，小于 1024 会按照 2 倍，超过会 1.25 倍递增扩容**

- **append 新增超过 cap 返回扩容的新切片，否则返回旧切片， copy 切片两个切片长度最小为 n 复制右切片 n 长度的值到左边切片， 删除切片中头尾部直接重新切片赋值，中间用 append 或者 copy 来做**

- **函数返回值如果只有一个可以只写类型，如果多个必须括号包裹起来，如果返回值中有一命名返回值，其余参数必须全部命名**

- **给 nil chan 发送接收都会导致阻塞，可以用来阻塞 main 协程**

- **无缓冲的 chan 是同步，有缓冲事异步**

- **cap 函数适用数组、切片、通道**

- **select随机选取通道执行一次用来处理通道 io，除了 defalt 其他都必须读写 chan, 多次外面操作加for循环,空select阻塞协程**

- **delete函数用来删除 map 键值**

- **函数和成员和方法名大小写决定包外可见行类似 public 和 private**

- **panic 只能本协程栈层层返回,所以为了不让程序崩溃所有协程最好 defer recover 恢复 panic, 多次 panic 只有最后一个 panic 被 recover**

- **同一个文件夹中包名只能有一个,不能出现多个**

- **defer后进先出栈结构,执行在return 之前**

- **除了nil任何值赋值给接口那么这个接口不再是nil,即使是一个nil初始值的引用类型**

```go
var a []int // a是nil
var c interface{} = a // c不是nil,存储了a
```

- **switch type 和.(类型)判断只能是接口变量才能编译通过**

- **iota 只能和 const 使用,每次 const 中间遇到 iota 都让他取当前 const 中的索引值从 0 开始**

## 知识点语法

### 切片的删除

```go
package main

import "fmt"

func main() {
	RemoveFromStart()
	fmt.Println()
	fmt.Println()
	RemoveFromTail()
	fmt.Println()
	fmt.Println()
	RemoveFromMiddle()
}

func RemoveFromStart() {
	fmt.Println("第一种方式.移动数据指针性能生成切片赋值给原变量. 性能最好,而且省内存,未动原内存不影响其他切片或者底层数组")
	func() {
		a := []int{0, 1, 2, 3, 4}
		a = a[1:]
		fmt.Println(a)
	}()

	fmt.Println("第二种方式.apend直接将底层的数据结构向开头移动生成新的切片赋值给原变量. 只拷贝操作，只是省内存,移动底层结构会影响其他切片和数组")
	func() {
		a := []int{0, 1, 2, 3, 4}
		a = append(a[:0], a[1:]...) //appen能初始化切片不一定需要make初始化
		fmt.Println(a)
	}()

	fmt.Println("第三种方式.copy同append只拷贝到开头，最后需要再切片一次保证底层的切片长度,然后赋值给原变量。优点同append")
	func() {
		a := []int{0, 1, 2, 3, 4}
		a = a[:copy(a, a[1:])]
		fmt.Println(a)
	}()
	fmt.Println("总结：第二第三种都能重新用新切片代替，避免移动了影响到其他切片或者底层数组")
}

func RemoveFromTail() {
	fmt.Println("总结：原理和从开头删除一致，参数位置，参数不同罢了")
}

func RemoveFromMiddle() {
	fmt.Println("第一种方式.apend直接将底层的数据结构向开头移动生成新的切片赋值给原变量. 只拷贝操作，只是省内存,移动底层结构会影响其他切片和数组")
	func() {
		a := []int{0, 1, 2, 3, 4}
		a = append(a[:2], a[3:]...) //appen能初始化切片不一定需要make初始化
		fmt.Println(a)
	}()

	fmt.Println("第二种方式.copy同append只拷贝移动后面部分，最后需要再切片一次保证底层的切片长度,然后赋值给原变量。优点同append")
	func() {
		a := []int{0, 1, 2, 3, 4}
		a = a[0 : 2+copy(a[2:], a[3:])]
		fmt.Println(a)
	}()

	fmt.Println("总结：必须移动后面的到中间去")
}
```

### Golang 阻塞
```go
// 1.死循环
	for {}

// 2.空select
	select{}

// 3.空chan,nil chan
	var c = make(chan int)
	c<- // 空chan直到有输入,同步阻塞
	var d chan int
	d<- // nil chan 永远阻塞

// 4.sync.Mutex
	var m sync.Mutex
	m.Lock()
	m.Lock()

// 5.sync.WaitGroup
	var wg sync.WaitGroup
	wg.Add(1)
	wg.Wait()

// 5.sync.cond条件变量
	var cond = sync.NewCond(new(sync.Mutex))
	go func(){
		cond.L.Lock() //获取锁
		// 只有一个协程执行两者之间代码中,到了cond.wait释放了锁,其他协程都能抢占执行这部分中间代码
		cond.Wait() //等待通知,里面继续抢互斥锁
		// 收到通知的程序执行代码,同样只有一个协程能执行这段代码,其他收到通知抢占进入执行
		cond.L.Unlock() //释放锁
	}()
	cond.Signal()    // 唤醒一个cond继续执行
	cond.Broadcast() // 唤醒所有的阻塞的cond

// 6.os.Signal
	sig := make(chan os.Signal, 2)
    signal.Notify(sig, syscall.SIGTERM, syscall.SIGINT)
    <-sig
```

### 定时器
golang中定时器有三种实现方式，分别是time.sleep、time.after、time.Timer其中time.after和time.Timer需要对通道进行释放才能达到定时的效果
```go
package main

import (
    "fmt"
    "time"
)

func main() {
    /*
        用sleep实现定时器
    */
    fmt.Println(time.Now())
    time.Sleep(time.Second)
	fmt.Println(time.Now())
	
	// 重置定时器 timer.Reset(d Duration) 过了d时间然后出通道执行后打代码
	// 停止定时器 timer.Stop()
    /*
        用timer实现定时器
    */
	timer := time.NewTimer(time.Second)

    fmt.Println(<-timer.C)
    /*
        用after实现定时器
    */
    fmt.Println(<-time.After(time.Second))
}
```

### 关闭channel
#### 1个发送者1个接收者
直接在发送端关闭
```golang
package main

import (
	"fmt"
	"time"
)

func main() {
	notify := make(chan int)

	datach := make(chan int, 100)

	go func() {
		<-notify
		fmt.Println("2 秒后接受到信号开始发送")
		for i := 0; i < 100; i++ {
			datach <- i
		}
		fmt.Println("发送端关闭数据通道")
		close(datach)
	}()

	time.Sleep(2 * time.Second)
	fmt.Println("开始通知发送信息")
	notify <- 1
	time.Sleep(1 * time.Second)
	fmt.Println("通知1秒后接收到数据通道数据 ")
	for {
		if i, ok := <-datach; ok {
			fmt.Println(i)

		} else {
			fmt.Println("接收不到数据中止循环")
			break
		}
	}

	time.Sleep(5 * time.Second)
}
```
#### 1个发送者N个接收者
同上也是直接在发送端关闭, 1个发送者1个接收者是特例


#### N个发送者1个接收者
N个发送者读取信号通道，接收者for range读取通道，接收者发送控制信号如close通道
```golang
package main

import (
"fmt"
"time"
"math/rand"
)

type T int

func main() {
	dataCh := make(chan T, 1)
	stopCh := make(chan T)
	//notifyCh := make(chan T)
	for i := 0; i < 10000; i++ {
		go func(i int) {

			for {
				value := T(rand.Intn(10000))

				select {
				case <-stopCh:
					fmt.Println("接收到停止发送的信号")
					return
				case dataCh <- value:

				}
			}
		}(i)
	}

	time.Sleep(1 * time.Second)
	fmt.Println("1秒后开始接收数据")
	for {
		if d, ok := <-dataCh; ok {
			fmt.Println(d)
			if d == 9999 {
				fmt.Println("当在接收端接收到9999时告诉发送端不要发送了")
				close(stopCh)
				return
			}
		} else {
			break
		}

	}
}
```
#### M个发送者N个接收者
通道有多个并发发送者，则不要关闭通道,让gc回收。file必须close因为是操作系统的资源，这里需要注意flag通道的关闭，重复关闭会导致panic，所以有三种方法:
1. 互斥锁判断关闭
2. sync.once
3. 在所有close的地方recover
在select前面判断还能再提高实时行关闭
```golang
package main

import (
	"log"
	"math/rand"
	"sync"
)

type T int

func main() {
	dataCh := make(chan T, 100)
	flag := make(chan bool)
	once := new (sync.Once)
	wg := new(sync.WaitGroup)
	wg.Add(50)
	for i := 0; i < 30; i++ {
		go func(i int) {
			defer wg.Done()
			for {
				value := T(rand.Intn(10))
				if value == 8 {
					once.Do(func() {
						close(flag)
					})
				}
				select {
				case <- flag:
					return
				case dataCh <- value:
				}
			}

		}(i)
	}
	//消费者
	for i := 0; i < 20; i++ {
		go func(i int) {
			defer wg.Done()
			for {
				select {
				case <-flag:
					return
				case value := <-dataCh:
					if value == 99 {
						once.Do(func() {
							close(flag)
						})
					}
					log.Println("receiver value :", value)
				}
			}
		}(i)
	}
	wg.Wait()
}
```
