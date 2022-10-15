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

## 基本难点

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
	var b MyInt = C // error报错因为,常量有类型,类型不一样不能赋值, 是类型元数据不一样
}
```
- **iota只能和const使用,iota每次都使值从const里的当前索引开始数**
```go
const (
	a = 1 << iota // 1
	b // 2
	c // 4
	d = iota // 这是const的第4行所以是4
	e // 5   
)
```

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

- **常量、变量、类型、接口、结构体、函数、等名称大小写决定包外可见性类似面向对象的public 和 private**

- **结构体的方法优先级高于匿名结构体或者匿名接口的方法，组合类似于继承但是不是继承, 继承能将子类转父类组合不行, go的组合是语法糖隐藏了匿名结构体的显示调用**

- **结构体内嵌接口可以实现多态, 为不同数据类型的实体提供统一的接口**

- **chan, map, slice变量为nil需要make分配空间才能用, slice可以用apend初始化空间, slice和map能用字面量声明来快速分配空间**

- **new函数会调用runtime.newobject在堆上开辟类型空间置0, 然后取址赋值给变量, 所以变量是一个指针类型永远不为nil, chan, map, slice不能用new初始化, 他们仅仅开辟空间未做初始化**

- **cap函数适用数组、切片、通道**

- **if语句块会遮挡外部定义的变量如命名返回值**

- **switch的case条件中能出现多个结果选项**

- **fallthrough不能在代码中间只有明确fallthrough才自动执行下一个且不经过case的判断**

- **如果switch不为空则case只能比较相等，如果 switch为空则case能写条件判断**

- **for循环不支持逗号隔开赋值，只支持平行赋值**

- **循环中break标签和continue标签不一样, break是直接跳出到标签不再进入循环, continue标签是 继续循环**

- **两个接口拥有相同的方法列表，方法次序可以不同，那么他们就是等价可以相互赋值，接口A是接口B的子级，B可以赋值给A, 这就是鸭子类型has-a**

- **值接收者和指针接收者都可以被指针变量和值变量调用成员方法, 区别是如果赋值接口, 接口的方法是指针接收者实现那么只能赋值指针变量**

- **给nil chan发送接收都会导致阻塞，可以用来阻塞main协程**

- **panic只能协程栈层层返回, 多次panic只有最后一个panic被recover**

- **golang的time.parse使用的utc时区，可以指定时区格式化, time.Format默认使用的本地时区**
```go
time.ParseInLocation("2006-01-02 15:04:05", "2017-12-03 22:01:02", time.Local)
```
## 复杂难点
- **手动创建的context.WithCancel需要最后需要手动放掉, 必然上下文协程会停留内存中造成内存泄漏, WithValue底层是空接口参数且用的==判断, 
	key的类型不应该是字符串类型或者其它内建类型，key的类型应该是自己定义的类型。如type metaDataKey struct{} **

- **select随机选取通道执行一次用来处理通道 io，除了defalt其他都必须读写 chan,空select阻塞协程, for循环select在进入该语句时，会按源码的顺序对每一个 case 子句进行求值.**
```go
	for {
		select {
		case <-time.After(time. * 3):
		// 会跳出select导致然后for循环又进入select调用time.After生成一个新的定时器从而内存泄漏
		case default:
		}
	}
```
- **golang传参值拷贝和c不一样, 比如字符串传参, 会拷贝字符串结构体, 内部引用的原始字符数据也会重新拷贝一次, 独立的字符空间, 并不是两个字符串引用同一块内存地址**

- **golang的不定参数和c不一样, c是caller栈开辟空间传递, go是使用切片传递, 切片的结构体三个属性会被拷贝成函数参数传递进去**

- **go保存函数闭包的上下文信息,也就是DX寄存器**

- **结构体方法作为实参传递的时候, 结构体方法会被编译器生成一个适配方法, 适配方法会将DX寄存器保存的上下文拆分出参数然后调用真正结构体方法**

- **汇编中传递参数使用寄存器 + 堆栈传参(SP上面空间), 不超过9个参数用寄存器, 实际编译后具体架构就不一定了, 所以go汇编还是封装了一层, C是编译成具体架构汇编**

- **使用寄存器传递返回值, 超出9个参数部分使用的是caller的栈空间. 也就是说传递参数和返回值都只会使用caller的栈空间或者只使用寄存器**

- **call指针接收器的方法第一个参数是隐藏的this指针也就是结构体的地址, 后面才是函数参数**

- **call值接收器的方法参数是使用到的结构体成员的参数值拷贝, 后面才是函数参数**
  
- **golang结构体方法参数中隐藏了自身参数, 所以go编译器会插入代码包装一个函数来模拟闭包捕获结构体然后调用结构体方法**

- **golang协程栈有初始值, 调用栈深了会扩容, 在函数中插入调用扩容判断函数. 所以函数变量逃逸超出本函数作用域,会放到堆区如指针变量. golang的协程栈也是位于堆区**

### zerobase 
当在任何地方定义无数个struct{}类型的变量，编译器都只是把这个zerobase变量的地址给出去, new也是,所以new出来的指针永远==。换句话说，
在golang里面，涉及到所有内存size为0的内存分配，那么就是用的同一个地址 &zerobase.


### unsafe.Pointer
1. 任何类型的指针都可以转化成 unsafe.Pointer；
2. unsafe.Pointer 可以转化成任何类型的指针；
3. uintptr 可以转换为 unsafe.Pointer；
4. unsafeP.ointer 可以转换为 uintptr；

unsafe.Pointer起到桥梁作用, uintptr搭配着unsafe.Pointer使用实现指针运,
值得注意的一点是unsafe.Pointer持有的内存区域会被gc回收, 所以需要保证内存持有变量后续还有被使用, 可以使用runtime.Keepalive保活指针, 
通常和unsafe.Pointer搭配, 确保unsafe操作在自动gc回收之前
### golang中的比较
- **golang可比较又可以分为两个小类:1. 可比较，包括相等(==)，和不相等(!=). 2.可排序，包括大于(>)，大于等于(>=)，小于(>)，小于等于(<=)**

- **可排序的数据类型三种: 整形, 浮点数, string**

- **可比较的数据类型: 可排序的类型, bool, complex, array(长度相等且内部非不可比较类型), struct(内部非不可比较类型), 
	chan(比较值相等), interface(内部非不可比较类型), ptr(只比较值相等)**

- **不可比较类型: func, map, slice, 不能比较会编译失败，结构体和数组存储这些类型的也编译失败**

- **空结构体不可相互比较没意义, 逃逸到堆比较是true, 未逃逸编译器返回false**

- **不同具体类型的比较会编译不过去, 接口可以和具体派生类型比较, 具体类型会转成接口然后比较, 用接口包装如果具体类型含有不可比较类型, 会触发panic, 
- 接口比较会退化原类型比较, 比如原类型是结构体那么比较字段值, 如果是指针比较指针地址**

- **接口本质: 长度16字节,空接口是rtype指针 + data指针, 非空接口是itab指针 + data指针, 如果接口赋值的是结构体那么会进行结构体拷贝然后新地址赋值给data指针, 
	如果是指针则直接赋值给data, ==比较是16个字节空间比较, 值得注意的是具体类型包含不可比较会类型会panic**
	
- **==比较就是简单值比较, reflect.DeepEqual能深层次比较如果是指针还能解引用比较值, 所以结果和==比较不是一致的, 
	就算是func, map, slice也能比较且不会panic,  chan如果不是同一个chan的结构体拷贝也会false, func类型除非都为nil, 否则会false, 
	基本类型, array, struct, interface, map, ptr, slice, 比较具体内容而不是值, 比如两个int指针引用的值都是1, 指针地址不一样, ==返回false,  DeepEqual返回true**

- **new(struct{})出来的指针永远相等**	
### 组合匿名结构体
- **组合结构体内嵌匿名结构体, 编译器会为组合结构体生成指针接收器方法(匿名结构体的所有方法), 值接收器只会生成匿名结构体值方法**
- **组合结构体内嵌匿名结构体指针, 编译器会为组合结构体生成指针接收器和值接收器方法(匿名结构体的所有方法)**
```go
package main

type A int

func (a A) Value() int {
	return int(a)
}

func (a *A) Set(n int) {
	*a = A(n)
}

type B struct {
	A
	b int
}

type C struct {
	*A
	c int
}
func main(){}
// 查看方法
// go tool compile -N -l main.go
// go tool nm ./main.o | grep ' T '
/*
    494e T main.(*A).Set           // 指针方法不会生成同名值方法
    57b5 T main.(*A).Value         // 编译器生成: 值方法会生成不存在的指针方法, 反之不成立, 主要是接口需要, 指针调用值方法不是包装方法, 是解引用然后调用值方法
    5841 T main.(*B).Set           // 编译器生成
    5852 T main.(*B).Value         // 编译器生成
    5941 T main.(*C).Set           // 编译器生成
    5955 T main.(*C).Value         // 编译器生成
    4920 T main.A.Value           
    58c7 T main.B.Value           // 编译器生成
    59d2 T main.C.Set             // 编译器生成
    5a4b T main.C.Value           // 编译器生成
    495e T main.main
*/	
```
### go中的接口断言
- **空接口是一个eface结构体有_type \*runtime.fttag._type和data unsafe.Pointe两个成员, 其中type是类型元数据指针, data是拷贝变量空间地址**

- **非空接口是一个iface结构体itab \*runtime.itab和data unsafe.Pointer两个成员, itab是由非空接口元数据信息和类型的组合结构体, 
	其中itab会被hashmap缓存下来, key是接口元数据的hash异或上类型元数据hash**
  
- **非空接口类型实际存放的是具体类型的指针,如果指针接口器不存在接口方法, 但是值接收器存在该方法, 
	编译器会生成指针接收器方法调用值接收器方法, 所以值接收器和指针接收器方法名不能重复**

1. 空接口.(具体类型)
因为每一个具体类型的元数据全局唯一, 直接判断_type是否等于断言具体类型元数据是否相等, 等于断言成功
2. 空接口.(非空接口)
通过_type的具体类型元数据和断言具体类型的元数据库找到itab且判断itab的func[0]是否等于0, 不等于就是断言成功, 等于就是没有实现断言失败. 
如果没有找到那么就会根据两个元数据类型检查方法然后生成itab并且缓存下下来
3. 非空接口.(具体类型)
itab缓存全局唯一, 直接判断itab是等于非空接口+断言具体类型的itab
4. 非空接口.(非空接口)
通过接口itab中的type得到实际类型元数据然后和非空接口元数据进行查找itab判断, 同理第二点

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
// 最后打印的永远是0, 默认运行等于GCC -O2级别的优化, 会寄存器级别优化，通过读取寄存器传值打印永远是0, 并没有从内存读取
// 解决办法: C/CPP的volatile是告诉编译器不要对这个变量的写入读取实时从内存读取(有cpu缓存)
// 但是因为L1上还有store buffer所以还有内存屏障的问题, 需要刷入cpu cache
// golang的方法也是同理, 使用happens-before的几条原则比如互斥锁和通道, 原理通道读取或者互斥锁加入了读写屏障
```
### GPM模型
**GPM模型，关于M的数量分析。Go 语言通过 Syscall 和 Rawsyscall 等使用汇编语言编写的方法封装了操作系统提供的所有系统调用**
1. 由于原子、互斥量或通道操作调用导致 Goroutine 阻塞，调度器将把当前阻塞的 Goroutine 切换出去，重新调度 LRQ 上的其他 Goroutine；并不会增加M的数量，golang并没有使用内核的互斥锁，所以并不会导致M陷入内核从而导致被golang开辟新的M。
2. 如果在 Goroutine 去执行一个 sleep 操作，导致 M 被阻塞了。Go 程序后台有一个监控线程 sysmon，它监控那些长时间运行的 G 任务然后设置可以强占的标识符，别的 Goroutine 就可以抢先进来执行。并不会增加M的数量
3. 由于网络请求和 IO 操作导致 Goroutine 阻塞。Go 程序提供了网络轮询器（NetPoller）来处理网络请求和 IO 操作的问题，其后台通过 kqueue（MacOS），epoll（Linux）或 iocp（Windows）来实现 IO 多路复用。
通过使用 NetPoller 进行网络系统调用，调度器可以防止 Goroutine 在进行这些系统调用时阻塞 M。这可以让 M 执行 P 的 LRQ 中其他的 Goroutines，而不需要创建新的 M。执行网络系统调用不需要额外的 M，
网络轮询器使用系统线程，它时刻处理一个有效的事件循环，有助于减少操作系统上的调度负载。用户层眼中看到的 Goroutine 中的"block socket"，实现了 goroutine-per-connection 简单的网络编程模式。
实际上是通过 Go runtime 中的 netpoller 通过 Non-block socket + I/O 多路复用机制"模拟"出来的。这个时候并不会增加M的数量。
4. 当调用一些系统方法的时候（如文件 I/O），如果系统方法调用的时候发生阻塞，这种情况下，网络轮询器（NetPoller）无法使用，而进行系统调用的 G1 将阻塞当前 M1。调度器引入 其它M 来服务 M1 的P。会增加M的数量，因为陷入内核等待响应。

- **sysmon协程的作用**
1. 检查死锁runtime.checkdead
2. 运行计时器 — 获取下一个需要被触发的计时器；
3. 定时从 netpoll 中获取 ready 的协程
4. Go 的抢占式调度
当 sysmon 发现 M 已运行同一个 G（Goroutine）10ms 以上时，它会将该 G 的内部参数 preempt 设置为 true。然后，在函数序言中，当 G 进行函数调用时，G 会检查自己的 preempt 标志，
如果它为 true，则它将自己与 M 分离并推入“全局队列”。由于它的工作方式（函数调用触发），在 for{} 的情况下并不会发生抢占，如果没有函数调用，即使设置了抢占标志，
也不会进行该标志的检查。Go1.14 引入抢占式调度（使用信号的异步抢占机制），sysmon 仍然会检测到运行了 10ms 以上的 G（goroutine）。然后，sysmon 向运行 G 的 P 发送信号（SIGURG）。
Go 的信号处理程序会调用P上的一个叫作 gsignal 的 goroutine 来处理该信号，将其映射到 M 而不是 G，并使其检查该信号。gsignal 看到抢占信号，停止正在运行的 G。
5. 在满足条件时触发垃圾收集回收内存；
6. 打印调度信息,归还内存等定时任务.

### GO常用编译参数
#### 去掉函数信息, 和调试信息
```bash
go build -ldflags '-s -w'
```
* -s: 去掉符号信息。
* -w: 去掉DWARF调试信息。
#### 关闭内联优化
```bash
go build -gcflags '-N -l'
```

### buildmode
* -buildmode=default
* [-buildmode=archive](#go-archive-shared)
* [-buildmode=shared](#go-archive-shared)
* [-buildmode=c-archive](#c-archive-shared) 
* [-buildmode=c-shared](#c-archive-shared)
* -buildmode=exe
* -buildmode=pie
* -buildmode=plugin
```bash
go help buildmode
```
#### <a id="go-archive-shared">go自身的动静库</a>
go可以将非main的包编译成go链接需要的动静态库, 然后编译main包的时候可以使用linkshared链接上去, -buildmode=shared暂不支持macOS.
好处有:
1. 动态库节省内存
2. 静态库节省编译速度

go本身编译就比较快, 且标准库都已经编译成静态库了在go安装目录有.a, 直接链接的, 所以第二点可以忽略. 

节省内存需要将库都拆分力度很细才有价值, 比如libzlog, libgin等才有价值, 包很多就增加了很大工作量, 这样才能进程之间共享. 
虽然容器内的动态库如果处于overlayfs驱动中能共享, 但是为了节省这点内存还是不划算, 当然也可以做.下面用标准库
```bash
# 将标准库
go install -buildmode=shared std

# main程序链接
go build -linkshared .
```

#### plugin
go1.18支持编译成plugin本质也是动态库, 通过plugin.Open可以打开然后Lookup找寻函数符号, 实现插件机制等同于c的dlopen

#### <a id="c-archive-shared">GO转c的动静态库</a>
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
go build -buildmode=c-archive -o hello.a .
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

### golang的CGO和动静态链接
CGO_ENABLED是控制是否开启C和GO混合编译,如果=0就是关闭,自然全是go代码自然是静态链接

CGO_ENABLED=1,开启C和GO混合编译自然有静态链接和动态链接之分

如果代码有C代码比如(net, os/user)等几个包的cgo代码, 就算C代码不依赖任何库, 默认会动态链接c库,如果加入`-ldflags '-extldflags "-static"'`会进行静态链接C库,
如果静态链接C的库有的库会报错, 可能是某些函数只存在动态库不存在静态库中

```bash
# 静态链接C库
go build -ldflags '-linkmode "external" -extldflags "-static"' .
# 关闭CGO，纯go语言构建
CGO_ENABLED=0 go build .
# 官方镜像构建go程序, 也可以用go mod vendor先导入依赖
sudo nerdctl run -it --rm --env GOPROXY=https://mirrors.cloud.tencent.com/go/ -v /home/x/go/:/go/ -v /home/x/workspace/go/go-demo:/home/app -w /home/app golang:1.17.0-buster bash
```
```ps1
### CMD
# set GOARCH=amd64
# set GOOS=linux
# set CGO_ENABLE=0

### ps1
# $env:GOOS="linux"
# $env:GOARCH="amd64"
# $env:CGO_ENABLE="0"
```
### Go汇编
```bash
# 第一种方式
go tool compile -N -l -S main.go

# 第二种方式
go tool objdump main.o

# 第三种方式
go build -gcflags -S main.go
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
### 内存对齐
内存对齐就是将数据的起始地址排列到cpu访问内存的倍数地址, 是因为cpu通过数据总线取数据的时候如果没有对齐到cpu的字长会增加读取次数消耗性能
计算机体系这种存取结构导致需要编译器或者人做内存对齐比如一个8字节你按照1字节对齐, 就会导致所有地址上都能作为起始点存放8字节, 
如果没有存储到地址0或者8的整数倍地址上, cpu会读取两次, 结构体需要手动调整对齐, 编译器自动对齐有可能存在空间浪费

所以内存对齐要求:
	1. 成员地址需要成员类型的整数倍(求余等于0)
	2. 结构体最终的大小(超过一个CPU字)需要是CPU字长的整数倍

第二点是考虑数组连续存放结构体, 如果没有对齐到字长的整数倍, 破坏第一点. 只有第一个结构体对齐了, 访问不受影响, 剩下的结构体成员访问有可能浪费cpu访问次数.

理论上你可以不对齐也就是全都按照1字节对齐, 只是会浪费cpu的性能罢了


### defer
协程上有一个defer链表, defer会在链表头插入defer结构体, 函数最后会执行defer链表

如果是defer捕获了外部变量, 那么外部变量会开辟到堆上, defer执行能修改外部变量

如果是defer传参, 那么赋值当前实参值到defer结构体中

如果是嵌套defer, 执行完一个defer, 父函数会判断下一个defer会的_defer.SP是不是和自己相等决定是否执行. 不要执行了别的函数的defer节点.因为共享的一个defer链表导致
也就是嵌套defer也是完全符合defer定义, 只有defer函数嵌套的defer执行完才会结束控制权移交给父函数

值得注意的一点是os.Exit后是不会执行defer的
### dlv
```bash
# 对go源码debug
go debug ./main.go

# 查看源文件列表
sources

# 查看函数
funcs

# 查看端点列表
bp

# 函数打端点
b main.main

# 重启进程
r 

# 走到断点
c

# 继续下一行
n

# 显示最上面栈帧列表
bt

# 查看寄存器
regs

# 查看栈变量
locals

# 协程列表
goroutines

# 切换协程
goroutine
```