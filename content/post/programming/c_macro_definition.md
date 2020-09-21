---
title: "C macro definition"
description: ""
lead: "" # 导读
# thumbnail: "/img/avatar.jpg" # Thumbnail image
categories:
  - "Programming"
tags:
  - "C"
  - "Syntax"
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
date: 2020-05-14T20:06:39+08:00
draft: false
---

## Get structure member offset bytes
You only need to include <stddef.h> to use offset
or write the following code
```c
#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
```

## <stdbool.h>
You can use Booleans as long as you include <stdbool.h>
```c
#ifndef _STDBOOL
#define _STDBOOL

#define __bool_true_false_are_defined 1

#ifndef __cplusplus

#define bool  _Bool
#define false 0
#define true  1

#endif /* __cplusplus */

#endif /* _STDBOOL */
```