---
title: "结构体"
date: 2021-08-31T10:29:00+08:00
lastmod: 2021-08-31T10:29:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "Syntax"
  - "C"
  - "Golang"
  - "Rust"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## 定义

```c
// c
#include <stdio.h>
typedef struct _user
{  
    char name[64];
    int  age;  
} user;  
int main(int argc, char *argv[])
{
    user user = {
        .name="jack",
        .age=20
    };
    printf("%s\n", user.name);
    printf("%d\n", user.age);
    return 0;
}
```

```go
// go
package main

import "fmt"

type user struct {
	name string
	age  int
}

func main() {
	var user = user{
		name: "jack",
		age:  22,
	}

	fmt.Println(user)
}
```

```rust
// rust
struct User {
    name: String,
    age: i32,
}
fn main() {
    let user = User {
        name: String::from("jack"),
        age: 32
    };
    println!("{} {}", user.name, user.age);
}
```
