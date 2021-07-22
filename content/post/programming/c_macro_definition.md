---
title: "C macro definition"
date: 2020-05-14T20:06:39+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "C"
  - "Syntax"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
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
