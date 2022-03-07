---
title: "HTTP"
date: 2019-08-27T17:28:00+08:00
lastmod: 2021-07-22T14:28:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "HTTP"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

### XMLHttpRequest
```js
var xhr = new XMLHttpRequest();
xhr.open('GET', 'https://test.juewei.com/a-service');
xhr.setRequestHeader("name", "yx");
xhr.send(null);
xhr.onload = function(e) {
    var xhr = e.target;
    console.log(xhr.responseText);
}

// 测试后端优雅重启
setInterval(() => {
    var xhr = new XMLHttpRequest()
    xhr.open("GET", "https://dev.juewei.com/order/actuator/health");
    // xhr.open("GET", "https://jrs-test.juewei.com/configs.js")
    // xhr.setRequestHeader("appEnv", "canary")
                                ;            
    xhr.send(null);
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var result = xhr.responseText;
            var json = eval("(" + result + ")");
            if (json.status != 'UP') {
                confirm(result)
            }
        };
    };
}, 10);
```

### 内网域名加载外网资源
```txt
公网网页加载内网资源会被高版本chrome阻止, 解决方案
1. chrome://flags/#block-insecure-private-network-requests配置chrome选项为disable 
2. 访问者资源加响应头  Access-Control-Allow-Private-Network
```
### 重定向
* 301 Moved Permanently
> 301 状态码表明目标资源被永久的移动到了一个新的 URI，任何未来对这个资源的引用都应该使用新的 URI。

* 308 Permanent Redirect
> 308 的定义实际上和 301 是一致的，唯一的区别在于，308 状态码不允许浏览器将原本为 POST 的请求重定向到 GET 请求上。

* 302 Found
> 302 状态码表示目标资源临时移动到了另一个 URI 上。由于重定向是临时发生的，所以客户端在之后的请求中还应该使用原本的 URI。服务器会在响应 Header 的 Location 字段中放上这个不同的 URI。浏览器可以使用 Location 中的 URI 进行自动重定向。用户代理可能会在重定向后的请求中把 POST 方法改为 GET 方法。如果不想这样，应该使用 307（Temporary Redirect） 状态码

* 303 See Other
> 303 常用于将 POST 请求重定向到 GET 请求，比如你上传了一份个人信息，服务器发回一个 303 响应，将你导向一个“上传成功”页面。

* 307 Temporary Redirect
> 307 的定义实际上和 302 是一致的，唯一的区别在于，307 状态码不允许浏览器将原本为 POST 的请求重定向到 GET 请求上。

总结:
301 308是永久的重定向, 区别是308不允许POST变GET请求

302 303 307是临时重定向, 302大多数浏览器等同303, 303告诉浏览器POST请求转GET请求Localtion地址, 区别307是POST不允许变GET请求(临时308)

