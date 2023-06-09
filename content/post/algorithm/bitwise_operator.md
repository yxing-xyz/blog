---
title: "比特运算"
date: 2017-11-23T11:28:03+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "算法"
tags:
  - "算法"
author: "何年重遇天涯"
---
比特运算
<!--more-->

## 基础

| 符号 |     描述 |                                       运算规则 |
| ---: | -------: | ---------------------------------------------: |
|    & |   按位与 |                          全为 1 为 1，否则为 0 |
|   \| |   按位或 |                          全为 0 为 0，否则为 1 |
|    ~ | 按位取反 |                                 0 变 1，1 变 0 |
|  \<< | 按位左移 | 各二进制位全部左移若干位，高位丢弃，低位补齐 0 |
|  \>> | 按位右移 |                             正数补 0，负数补 1 |
|    ^ | 按位异或 |                                  相同 0,相异 1 |

**注意:**

1. 在这 6 种操作符，只有~取反是单目操作符，其它 5 种都是双目操作符
2. 位操作只能用于整形数据，对 float 和 double 类型进行位操作会被编译器报错
3. 注意运算符优先级，除了~其余都运算符等级都比较低。

## 技巧

### 1.变换符号位

```c
   int a = -100;
   a = ~a + 1;
```

### 2.判断奇偶数

```c
   if(i & 1)
	   printf("奇数");
   else
	   printf("偶数");
```

### 3.小写转大写

```c
   char str = 'a';
   str &= 0xDF; // A - a = 32 = 0xDF
   printf("%c",str);
   return 0;)
```

### 4.交换两数

```c
   int a=1,b=2;
   a ^= b;
   b ^= a;
   a ^= b;
   printf("%d,%d", a,b);
```

### 5.求绝对值

```c
    int a = -100;
    int i = a >> (sizeof(a) * 8 - 1);
    a = ((a ^ i) - i);
    printf("%d", a);
```

### 6.防溢出式求平均数

```c
   int avg=(x&y) +((x^y)>>1);
   // x&y相当于二进制都为1(x的1和y的1)保留,等于公共部分相加然后除2
   // (x^y)>>1 相当于二进制不同部分相加，然后>> 1等于除2
```

### 7.数据类型高低位交换(必须是无符号整数)

```c
   void PrintfBinary(int a) {
	   int i;
       for (i = sizeof(a) * 8 - 1; i >= 0; --i) {
	       if ((a >> i) & 1)
		       putchar('1');
		   else
			   putchar('0');
	   }
	   putchar('\n');
   }
   unsigned int a = -2;
   PrintfBinary(a);
   unsigned char half = sizeof(a) * 4;
   a = (a >> half | a << half);
   PrintfBinary(a);
```

### 8. 内存对齐, 清0低位且进位
清0低位是很容操作的与运算即可,
进1就要低位加上低位取反+1
```golang
// 进位清0最低三位, 内存对齐8字节
const (
	maxAlign = 8
   // 负号等于按位取反+1保留进位
	hchanSize = unsafe.Sizeof(hchan{}) + uintptr(-int(unsafe.Sizeof(hchan{}))&(maxAlign-1))
)
```

### 四舍五入
cent单位分， money单位元
这里可以位与运算实现floor
```go
func round(cent int) int64 {
	 return int64(math.Floor(float64(cent)/100 + 0.5))
}
```