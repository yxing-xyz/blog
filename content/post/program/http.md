---
title: "HTTP协议"
date: 2021-11-14T13:20:00+08:00
lastmod: 2023-06-12T16:52:00+08:00
draft: false
categories:
  - "编程"
tags:
  - "编程"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. 重定向
2. Nginx配置重定向使用相对路径
3. HTTP代理
<!--more-->
### 重定向
* 301 Moved Permanently
> 301状态码表明目标资源被永久的移动到了一个新的URI，任何未来对这个资源的引用都应该使用新的URI。

* 308 Permanent Redirect
> 308的定义实际上和301是一致的，唯一的区别在于，308状态码不允许浏览器将原本为 POST的请求重定向到GET请求上。

* 302 Found
> 302状态码表示目标资源临时移动到了另一个URI上。由于重定向是临时发生的，所以客户端在之后的请求中还应该使用原本的 URI。服务器会在响应 Header 的 Location 字段中放上这个不同的 URI。浏览器可以使用Location中的URI进行自动重定向。用户代理可能会在重定向后的请求中把POST方法改为GET方法。如果不想这样，应该使用307(Temporary Redirect)状态码

* 303 See Other
> 303常用于将POST请求重定向到GET请求，比如你上传了一份个人信息，服务器发回一个303响应，将你导向一个"上传成功"页面。

* 307 Temporary Redirect
> 307的定义实际上和302是一致的，唯一的区别在于，307状态码不允许浏览器将原本为POST的请求重定向到GET请求上。

总结:
301 308是永久的重定向, 区别是308不允许POST变GET请求

302 303 307是临时重定向, 302大多数浏览器等同303, 303告诉浏览器POST请求转GET请求Localtion地址, 区别307是POST不允许变GET请求
### Nginx配置重定向使用相对路径
absolute_redirect off;

### HTTP代理
客户端知道走了正向代理，不知道是否访问了反向代理,
CONNECT后续也可以跟着http包文，如websocket请求
1. 正向代理http请求报文等于反向代理，区别就是反向代理请求TCP端口和HTTP报文端口一致,正向代理TCP端口是代理程序监听的端口，报文里是资源服务器端口，http请求可以通过设置正向代理到反向代理服务器来规避DNS解析问题。
2. 正向代理https请求,会有一个connect请求,服务器响应HTTP/1.1 200 Connection Established,代理服务器收到后和资源服务器建立tcp连接，然后原封不动转发tcp数据，并不知道内容，只知道域名和端口信息.
