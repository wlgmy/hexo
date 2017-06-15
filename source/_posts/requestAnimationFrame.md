---
title: requestAnimationFrame
date: 2017-06-15 14:33:14
tags:
---

## 概述

requestAnimationFrame是浏览器用于定时循环操作，类似于setTimeout的一个接口，只不过setTimeout是用户自定义定时时间，而requestAnimationFrame则是利用浏览器的刷新机制，根据浏览器/显示器的刷新频率（60HZ或者75HZ）来执行定时操作。因此这个方法在做逐帧动画的时候非常适用。
## 语法
>注意:
如果您想在下一个重绘时为另一个框架设置动画，您的回调例程必须调用 requestAnimationFrame()。

```javascript
requestID = window.requestAnimationFrame(callback);               // Firefox 23 / IE10 / Chrome / Safari 7 (incl. iOS)
requestID = window.mozRequestAnimationFrame(callback);                // Firefox < 23
requestID = window.webkitRequestAnimationFrame(callback); // Older versions Chrome/Webkit
```
目前，主要浏览器(Firefox 23 / IE 10 / Chrome / Safari）都支持这个方法 [点击查看兼容性测试](https://caniuse.com/#search=requestAnimationFrame)。对于没有实现requestAnimationFrame方法的浏览器，由于requestAnimationFrame和setTimeout一样采用回调的方式,因此可以在没有实现requestAnimationFrame的浏览器中才用setTimeout作为备胎，下面放上一段由Paul Irish及其他贡献者放在GitHub Gist上的代码片段，用以在浏览器不支持requestAnimationFrame的情况下使用setTimeout作为备胎方案
```javascript
// http://paulirish.com/2011/requestanimationframe-for-smart-animating/
// http://my.opera.com/emoller/blog/2011/12/20/requestanimationframe-for-smart-er-animating
// requestAnimationFrame polyfill by Erik Möller. fixes from Paul Irish and Tino Zijdel
// MIT license
(function() {
    var lastTime = 0;
    var vendors = ['ms', 'moz', 'webkit', 'o'];
    for (var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
        window.requestAnimationFrame = window[vendors[x] + 'RequestAnimationFrame'];
        window.cancelAnimationFrame = window[vendors[x] + 'CancelAnimationFrame'] || window[vendors[x] + 'CancelRequestAnimationFrame'];
    }
    if (!window.requestAnimationFrame) window.requestAnimationFrame = function(callback, element) {
        var currTime = new Date().getTime();
        var timeToCall = Math.max(0, 16 - (currTime - lastTime));
        var id = window.setTimeout(function() {
            callback(currTime + timeToCall);
        }, timeToCall);
        lastTime = currTime + timeToCall;
        return id;
    };
    if (!window.cancelAnimationFrame) window.cancelAnimationFrame = function(id) {
        clearTimeout(id);
    };
}());

```
> 例子

```javascript
// useage
var start = null;
var d = document.getElementById('SomeElementYouWantToAnimate');
function step(timestamp) {
  if (start === null) start = timestamp;
  var progress = timestamp - start;
  d.style.left = Math.min(progress/10, 200) + "px";
  if (progress < 2000) {
    requestAnimationFrame(step);
  }
}
requestAnimationFrame(step);
```

## 参考链接

#### MDN [window.requestAnimationFrame](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/requestAnimationFrame)

#### Paul Lrish [requestAnimationFrame for Smart Animating](https://www.paulirish.com/2011/requestanimationframe-for-smart-animating/)
