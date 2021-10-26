---
title: "Golang"
date: 2020-08-05T23:08:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "Syntax"
  - "Golang"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
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
- **iota只能和const使用,iota每次都使值从0开始**

- **同一个包里面函数名,接口名,结构体名,全局变量,全局常量不能重名**
```go
func A(){} // error
type A interface{} // error
type A struct{} // error
const A // error
var A int // errro
```

- **包中可以包含多个 init 函数，先执行导入包的 init 函数，然后 main 包 init，然后 main 函数**

- **main函数不能带参数，不能有返回值，且必须在 main 包中**

- **同一个文件夹中包名只能有一个,不能出现多个**

- **type定义的结构体或者新类型只能在其所在包中接收方法，包外不可以接收方法**

- **常量、变量、类型、接口、结构体、函数、等名称大小写决定包外可见行类似 public 和 private**

- **结构体的方法优先级高于匿名结构体或者匿名接口的方法，可以模拟继承**
```go
type I interface {
	func A()
	func B()
}

type son struct {}
func(r *son) A() {}
func(r *son) B() {}

type parent struct {
	I
}

func(r *parent) A() {}
```

- **函数返回值如果只有一个类型,可以只写类型，如果多个类型必须括号包裹起来，如果返回值中有一命名返回值，其余参数必须全部命名**

- **golang的time.parse使用的utc时区，可以指定时区格式化, time.Format默认使用的本地时区**
```go
time.ParseInLocation("2006-01-02 15:04:05", "2017-12-03 22:01:02", time.Local)
```

- **chan, map, slice变量为nil需要make分配空间才能用, slice可以用apend初始化空间, slice和map能用字面量声明来快速分配空间**

- **delete函数用来删除map键值**

- **当切片达到cap容量时继续append 会扩大 cap，小于 1024 会按照 2 倍，超过会 1.25 倍递增扩容**

- **append超过cap返回扩容的新切片，否则返回旧切片**

- **cap 函数适用数组、切片、通道**

- **给 nil chan 发送接收都会导致阻塞，可以用来阻塞 main 协程**

- **select随机选取通道执行一次用来处理通道 io，除了defalt其他都必须读写 chan,空select阻塞协程, select每次在进入该语句时，会按源码的顺序对每一个 case 子句进行求值：这个求值只针对发送或接收操作的额外表达式,time.After每次返回一个chan Time导致内存泄漏**

- **if语句块会遮挡外部定义的变量如命名返回值,导致 bug 所以变量尽量定义到外面**

- **switch的case条件中能出现多个结果选项**

- **fallthrough不能在代码中间只有明确fallthrough才自动执行下一个且不经过case的判断**

- **如果switch不为空则case只能比较相等，如果 switch为空则case能写条件判断**

- **for 循环不支持逗号隔开赋值，只支持平行赋值**

- **for range里面的闭包和协程很容易出错因为使用副本和指向地址没改变**

- **type 新类型 类型这种方式可以挂方法,type 别名 = 也类似宏定义,不能在包外挂方法,这是和 type 类型的区别, 可以通过类型转换新类型和旧类型**

- **两个接口拥有相同的方法列表，方法次序可以不同，那么他们就是等价可以相互赋值，接口 A 是接口 B 的子级，B 可以赋值给 A**

- **类型实现接口接收者是指针,那么只有该变量的指针能赋值给接口类型变量，结构体是否实现接口需要综合成员的匿名结构体或者接口来看是否满足接口的所有方法**

- **Go语言中规定，只有类型（Type）和指向他们的指针（*Type）才是可能会出现在接收器声明里的两种接收器，为了避免歧义，明确规定，新类型是指针，接口是不能出现在接收器**


- **除了nil任何值赋值给接口那么这个接口不再是nil,即使是一个nil初始值的引用类型**
```go
var a []int // a是nil
var c interface{} = a // c不是nil,引用了a
```

- **switch type 和.(类型)判断只能是接口变量才能编译通过,因为只有接口实际隐藏了变量的其他类型只保留接口方法调用相等于泛化了**

- **panic 只能本协程栈层层返回,所以为了不让程序崩溃, web协程最好 defer recover 恢复 panic, 多次panic只有最后一个panic被recover**

- **defer后进先出栈结构,执行在return 之前**

## 重点语法


### golang中的比较
- **golang可比较又可以分为两个小类:1. 可比较，包括相等(==)，和不相等(!=). 2.可排序，包括大于(>)，大于等于(>=)，小于(>)，小于等于(<=)**

- **可排序的数据类型三种: 整形, 浮点数, 字符串**

- **可比较的数据类型: 可排序的类型, 布尔类型, 复数, array, struct, 通道, 接口, 指针**

- **不可比较类型: func, map, slice, 不能和自身类型比较编译不过，结构体和数组存储这些类型的也编译不过, 用空接口强行比较运行会panic**

- **不是单纯比较变量寄存器的值, 这点和c语言和java不一样,c和java以字符串举例都是一个寄存器变量对应一个复合结构,比较只会比较寄存器的值是否相同, 这样就会导致同样的字符串却不想等,所以c需要用strcmp而java需要用equal方法, golang的==做了很多操作,更加偏上层和脚本语言.**

- **不同类型的比较会编译不过去, 注意不同名称接口如果内部方法一模一样是同类型, 用接口接收比较会先比较类型,然后比较类型的值,如果类型不可比较类型会panic**

### golang的内存屏障案例
```go
package main

import (
	"fmt"
	"time"
)

func main() {
	y := 0
	go func() {
		for {
			y++
		}
	}()
	time.Sleep(time.Second * 2)
	fmt.Println(y)
}
// 最后打印的永远是0, 默认运行等于GCC -O2级别的优化, 不会开启内存屏障.
// 解决办法: 可以用atomic模拟volatile或者mutex,底层都是刷入内存和从内存中读取.
```
### GPM模型
- **GPM模型，关于M的数量分析。Go 语言通过 Syscall 和 Rawsyscall 等使用汇编语言编写的方法封装了操作系统提供的所有系统调
1. 由于原子、互斥量或通道操作调用导致 Goroutine 阻塞，调度器将把当前阻塞的 Goroutine 切换出去，重新调度 LRQ 上的其他 Goroutine；并不会增加M的数量，golang并没有使用内核的互斥锁，所以并不会导致M陷入内核从而导致被golang开辟新的M。
2. 如果在 Goroutine 去执行一个 sleep 操作，导致 M 被阻塞了。Go 程序后台有一个监控线程 sysmon，它监控那些长时间运行的 G 任务然后设置可以强占的标识符，别的 Goroutine 就可以抢先进来执行。并不会增加M的数量
3. 由于网络请求和 IO 操作导致 Goroutine 阻塞。Go 程序提供了网络轮询器（NetPoller）来处理网络请求和 IO 操作的问题，其后台通过 kqueue（MacOS），epoll（Linux）或 iocp（Windows）来实现 IO 多路复用。通过使用 NetPoller 进行网络系统调用，调度器可以防止 Goroutine 在进行这些系统调用时阻塞 M。这可以让 M 执行 P 的 LRQ 中其他的 Goroutines，而不需要创建新的 M。执行网络系统调用不需要额外的 M，网络轮询器使用系统线程，它时刻处理一个有效的事件循环，有助于减少操作系统上的调度负载。用户层眼中看到的 Goroutine 中的“block socket”，实现了 goroutine-per-connection 简单的网络编程模式。实际上是通过 Go runtime 中的 netpoller 通过 Non-block socket + I/O 多路复用机制“模拟”出来的。这个时候并不会增加M的数量。
4. 当调用一些系统方法的时候（如文件 I/O），如果系统方法调用的时候发生阻塞，这种情况下，网络轮询器（NetPoller）无法使用，而进行系统调用的 G1 将阻塞当前 M1。调度器引入 其它M 来服务 M1 的P。会增加M的数量，因为陷入内核等待响应。

- **sysmon协程的作用**
1. 检查死锁runtime.checkdead
2. 运行计时器 — 获取下一个需要被触发的计时器；
3. 定时从 netpoll 中获取 ready 的协程
4. Go 的抢占式调度
当 sysmon 发现 M 已运行同一个 G（Goroutine）10ms 以上时，它会将该 G 的内部参数 preempt 设置为 true。然后，在函数序言中，当 G 进行函数调用时，G 会检查自己的 preempt 标志，如果它为 true，则它将自己与 M 分离并推入“全局队列”。由于它的工作方式（函数调用触发），在 for{} 的情况下并不会发生抢占，如果没有函数调用，即使设置了抢占标志，也不会进行该标志的检查。Go1.14 引入抢占式调度（使用信号的异步抢占机制），sysmon 仍然会检测到运行了 10ms 以上的 G（goroutine）。然后，sysmon 向运行 G 的 P 发送信号（SIGURG）。Go 的信号处理程序会调用P上的一个叫作 gsignal 的 goroutine 来处理该信号，将其映射到 M 而不是 G，并使其检查该信号。gsignal 看到抢占信号，停止正在运行的 G。
5. 在满足条件时触发垃圾收集回收内存；
6. 打印调度信息,归还内存等定时任务.

### golang的CGO和动静态链接

CGO_ENABLED是控制是否开启C和GO混合编译,如果=0就是关闭,自然全是go代码自然是静态链接

CGO_ENABLED=1,开启C和GO混合编译自然有静态链接和动态链接之分

如果代码有C代码比如(net, os/user)等几个包的cgo代码, 就算C代码不依赖任何库, 默认会动态链接c库,如果加入`-ldflags '-extldflags "-static"'`会进行静态链接C库,
经测试如果静态链接C的库有的库会报错,可能某些方法只存在C的动态库中
```bash
# 静态链接C库
go build -ldflags '-linkmode "external" -extldflags "-static"' .
# 关闭CGO，纯go语言构建
CGO_ENABLED=0 go build .
# 官方镜像构建go程序
sudo nerdctl run -it --rm --env GOPROXY=https://mirrors.cloud.tencent.com/go/ -v /home/x/go/:/go/ -v /home/x/workspace/go/go-demo:/home/app -w /home/app golang:1.17.0-buster bash
```
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
		a = append(a[:0], a[1:]...) //append能初始化切片不一定需要make初始化
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


    fmt.Println(<-timer.C)
    /*
        用after实现定时器
    */
    fmt.Println(<-time.After(time.Second))


    // 重置定时器 timer.Reset(d Duration) 过了d时间然后出通道执行后打代码
    // 停止定时器 timer.Stop()
    /*
        用timer实现定时器
    */
    timer := time.NewTimer(time.Second)
}
```

### 关闭channel
接受端和发送端都可以关闭通道,一般来说都是在发送端关闭,因为接收端能读取到通道已经关闭的状态.因为只需要注意:
1. 通道重复关闭会panic
2. 通道关闭后,从通道读取会返回false状态
#### 1个发送者N个接收者,
N取值1..N, 直接在发送端关闭即可.
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


### 文件读写
```go
package main

import (
	"bufio"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"time"
)

// import "github.com/gin-gonic/gin"

func chekErr(err error) {
	if err != nil {
		panic(err)
	}
}
func main() {
	// 第一种
	fd, err := os.OpenFile("./a", os.O_CREATE|os.O_TRUNC|os.O_WRONLY, 0666)
	chekErr(err)
	n, err := fd.Write([]byte("file.Write\n"))
	chekErr(err)
	fmt.Printf("第一种写入字节: %d\n", n)

    // 第二种: ioutil是包装os调用os.WriteFile调用os.OpenFile固定参数O_WRONLY|O_CREATE|O_TRUNC会清空文件,然后调用File的方法
	err = ioutil.WriteFile("./b", []byte("ioutil.WriteFile\n"), 0666)
	chekErr(err)

	// 第三种: 也是调用file.Write，File实现了接口WriteString,调用这个接口方法
	n, err = io.WriteString(fd, "io.WriteString\n")
	chekErr(err)
	fmt.Printf("第二种写入字节: %d\n", n)
	time.Sleep(time.Millisecond * 10)


	// 第四种: bufio.NewWriter包装file
	w := bufio.NewWriter(fd)
	n, err = w.WriteString("bufio.Writer\n")
	chekErr(err)
	fmt.Printf("第三种写入字节: %d\n", n)
	w.Flush()

	// sync函数只是将所有修改过的块缓冲区排入写队列，然后就返回，它并不等待实际写磁盘操作结束。

	// fsync函数只对由文件描述符filedes指定的单一文件起作用，并且等待写磁盘操作结束，然后返回。fsync可用于数据库这样的应用程序，
	// 这种应用程序需要确保将修改过的块立即写到磁盘上。

	// fdatasync函数类似于fsync，但它只影响文件的数据部分。而除数据外，fsync还会同步更新文件的属性。

	fd.Sync()
	fd.Close()


}
```

### GO编译动态库
go调用c库是常规操作，可以反过来让c调go的动态库
动态库代码
```go
package main // 这个文件一定要在main包下面

import "C" // 这个 import 也是必须的，有了这个才能生成 .h 文件
// 下面这一行不是注释，是导出为SO库的标准写法，注意 export前面不能有空格！！！
//export hello
func hello(value string) *C.char { // 如果函数有返回值，则要将返回值转换为C语言对应的类型
	return C.CString("hello" + value)
}
func main() {
	// 此处一定要有main函数，有main函数才能让cgo编译器去把包编译成C的库
}
```
构建动静态库命令
```bash
# 动态库
go build -buildmode=c-shared -o hello.so .
# 静态库
go build -buildmode=c-archive -o hello.so .
```
C代码
```c
#include <stdio.h>
#include <string.h>
#include "hello.h" // 此处为上一步生成的.h文件

int main(){
    char c1[] = "did";
    GoString s1 = {c1,strlen(c1)};// 构建go类型
    char *c = hello(s1);
    printf("r:%s",c);
    return 0;
}
```
C链接动态库并运行
```bash
# 动态库
gcc -o main main.c hello.so
# 静态库(go的静态库需要连接pthread)
gcc -o main main.c hello.a -lpthread
```
