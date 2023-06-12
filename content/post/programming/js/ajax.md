---
title: "Ajax"
date: 2021-06-16T19:49:00+08:00
lastmod: 2023-06-12T17:50:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "JavaScript"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
## Ajax

### 跨域
### SIMPLE
```bash
curl -i -X GET \
   -H "Sec-Fetch-Mode:cors" \
   -H "Sec-Fetch-Site:cross-site" \
   -H "Sec-Fetch-Dest:empty" \
   -H "Referer:https://www.baidu.com/" \
   -H "Origin:https://www.baidu.com" \
 'https://test.juewei.com/a-service'
```

### OPTIONS
```bash
curl -i -X OPTIONS \
   -H "Sec-Fetch-Mode:cors" \
   -H "Sec-Fetch-Site:cross-site" \
   -H "Sec-Fetch-Dest:empty" \
   -H "Referer:https://www.baidu.com/" \
   -H "Origin:https://www.baidu.com" \
   -H "Access-Control-Request-Method:GET" \
   -H "Access-Control-Request-Headers:x-b3-sampled" \
 'https://test.juewei.com/a-service'
```

```js
var xhr = new XMLHttpRequest();
xhr.open('GET', 'https://test.juewei.com/a-service');
xhr.setRequestHeader("name", "yx");
xhr.send(null);
xhr.onload = function(e) {
    var xhr = e.target;
    console.log(xhr.responseText);
}
```