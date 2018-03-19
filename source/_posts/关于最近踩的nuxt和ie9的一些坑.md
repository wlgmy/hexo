---
title: 关于最近踩的nuxt和ie9的一些坑
date: 2018-03-19 15:22:57
tags:
---
最近新上线一个类似于官网项目，为了SEO考虑，我们采用了[NUXT](https://nuxtjs.org/)框架。由于是PC官网，就要兼容令所有WEB开发者头疼的历史上最神奇的浏览器：IE，起先，我们要求只兼容到IE10，好在IE10比较成熟，开发起来也没有特别的地方，直到有一天，老板突然告诉我们一个晴天霹雳：我们要兼容到IE9。。。当我们千辛万苦的装了一台有IE9的win7系统打开我们的页面之后，集体惊呆，这特么是个啥玩意儿，页面怎么这么丑，布局全乱了，视频也不能播放了，websocket也没了，异步请求的数据也没了。。。接下来就是漫漫填坑之旅了
## 关于布局
flex不兼容IE9！flex不兼容IE9！flex不兼容IE9！重要的事情说三遍。。。以前我们都是做的微信端的网页开发，flex布局用起来不要太得心应手，之前要求兼容到IE10，通过[caniuse](https://caniuse.com/#search=flex)查询发现IE10还是兼容flex的，所以就放心大胆的用了，现在，我们只能重拾web面试中不可避免的问题：如何实现元素垂直居中；如何实现元素左右居中；什么是BFC。。。
## 关于视频播放
关于直播插件，我们用的是马爸爸家的[aliplayer](https://player.alicdn.com/aliplayer/index.html)但是有一个问题就是：默认情况下，aliplayer在播放flv格式视频的时候并没有使用flash播放，然后直播在IE9下就瓦特了，无奈只能手动设置在IE9下强制使用flash播放器了
```javascript
useFlashPrism: isIE9 && this.isLive
```
还有一个问题就是马爸爸的播放器在切换两个flv格式的视频的时候会出现一个不可思议的错误：他们调用了一个未定义的函数(版本：2.5.1)。。。无奈，我们只能每次切换视频的时候都将之前的player对象销毁后新建了
## 关于网络请求
IE9不支持websocket，我们的行情和聊天等实时数据只能靠轮询了。。。
IE9不支持跨域的网络请求，我们只能搭了一套NGINX代理。
## 关于IE9下的vue-router
IE9不支持history模式，所以vue-router会在IE9下将路径转换为hash模式，这就导致了我们每次切换页面的时候，会有一次hash的跳转，然而nuxt在hash跳转后将原本应该在服务端拿到并绑定到页面的数据并没有绑定过来。。。也就是说在这种情况下，所有数据只能客户端去拿，这样就失去了服务端渲染的意义了。后来查找了vue-router的相关文档，终于发现了一丝曙光，通过更改vue-router的fallback属性为false来激活nuxt在IE9下采用纯服务端渲染，然而IE9的控制台无情的给我们报了一个错误：
```javascript
[nuxt] Error while initializing app TypeError: 对象不支持“replaceState”属性或方法
```
于是我们又手动给IE9写了一个replaceState方法
```javascript
if (process.client) {
  window.history.replaceState = window.history.replaceState || function () {}
}
```
注意一定要加上window！
## 关于NUXT
> middleware在首次进入的时候只会执行服务端，后面切换路由才会客户端和服务端都执行

> 如果需要每次客户端执行，可以将代码放在plugin里，这样的话就能保证无论是首次进入还是后续切换路由代码都会在服务端和客户端执行

暂时只想到了这么些个坑，以后遇到了再继续补充
