---
title: "时间相关的算法"
date: 2021-10-26T15:28:00+08:00
lastmod: 2021-10-26T15:28:00+08:00
draft: false
categories:
  - "Algorithm"
tags:
  - "Algorithm"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

## 北京时间日期向下取整
```go
// t 时间戳 2021-10-26T15:28:00+08:00  返回 2021-10-26T00:00:00+08:00
func FloorInCST(t int64) int64 {
	return t - (t + 8*3600)%86400
}
```