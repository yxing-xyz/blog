---
title: "Golang Develop"
date: 2023-02-01T19:37:00+08:00
lastmod: 2023-02-01T19:37:00+08:00
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
### Gorm支持多行SQL语句
MySQL DSN使用参数`multiStatements=true`
```golang
package main

import (
	"fmt"

	"gorm.io/driver/mysql"
	_ "gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func main() {
	dsn := "root:Yuns3NaiC2a@tcp(127.0.0.1:3306)/learn_golang?charset=utf8mb4&parseTime=True&loc=Local&multiStatements=true"
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
}
```