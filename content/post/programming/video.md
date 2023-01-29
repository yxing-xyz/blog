---
title: "Ajax Cors"
date: 2023-01-29T20:09:00+08:00
lastmod: 2023-01-29T20:09:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "JavaScript"
  - "Bash"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
## 浏览器js获取用户媒体数据
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
      video {
        display: block;
        margin: 0 auto;
      }
      canvas {
        display: none;
      }
    </style>
    <title>Document</title>
  </head>
  <body>
    <video autoplay id="video"></video>
    <br />
    <canvas id="output"></canvas>
  </body>
</html>
<script>
  //var video = document.getElementById('video')
  //var back = document.getElementById('output')
  var video = $("#video").get(0);
  var back = $("#output").get(0);
  //console.log(back,video)
  var backcontext = back.getContext("2d");
  function draw() {
    backcontext.drawImage(video, 0, 0, back.width, back.height);
    try {
      backcontext.drawImage(video, 0, 0, back.width, back.height);
    } catch (e) {
      if (e.name == "NS_ERROR_NOT_AVAILABLE") {
        return setInterval(draw, 200);
      } else {
        throw e;
      }
    }
    setTimeout(draw, 200);
  }
  var success = function (stream) {
    console.log("摄像头开启成功");
    //videoUrl = window.URL.createObjectURL(stream)
    //video.src = videoUrl
    video.srcObject = stream;
    draw();
  };
  var error = (error) => {
    alert("调用失败");
  };
  navigator.getUserMedia =
    navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia;
  navigator.getUserMedia({ video: true, audio: false }, success, error);
</script>
```