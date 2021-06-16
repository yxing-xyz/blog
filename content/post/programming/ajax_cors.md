---
title: "Ajax Cors"
date: 2021-06-16T19:49:00+08:00
description: "Ajax Cors"
categories:
  - "Programming"
tags:
  - "JavaScript"
  - "Bash"
# thumbnail: "/img/avatar.jpg" # Thumbnail image
lead: "Ajax Cors" # 导读
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---
## Ajax

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