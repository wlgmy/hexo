---
title: Hexo搭建个人博客
date: 2017-06-14 14:16:46
tags:
---
本文简单介绍下如何通过HEXO以及Github来搭建个人博客

## 准备工作

> 申请Github账户

  如若想要通过github来作为自己博客的服务器，则必须要有自己的github账户。
  如若自己有云服务器和域名，也可以部署至自己的私服，则不需要github账户，建议采用github部署
> 安装node

  node为本地开发，编译hexo的工具，安装方法根据所用平台不同可自行百度
> 安装git

  代码管理工具，也是将hexo内容提交到Github上的工具

## 本地环境搭建

>安装HEXO

当安装好node和git后，可执行如下命令安装HEXO：
```bash
npm install -g hexo-cli
```
> 初始化

创建自己的博客文件夹，比如hexo，然后到该文件目录下执行：
```bash
hexo init
```
至此你可以看到在当前目录下生成了hexo相关的文件

## 创建你的第一篇博客

> 新建博客

```bash
  hexo new 'your_first_blog_name'
```

> 编写博客内容

在source/_posts/文件目录下回生成一个your_first_blog_name.md文件，任意编辑器打开编辑该文件即可（注：hexo默认采用markdown语法书写，不熟悉语法的同学可以百度[markdown语法](http://www.appinn.com/markdown/basic.html)）

> 本地预览

```bash
  hexo server
```
执行该条命令后控制台会输出本地预览地址，默认为：http://localhost:4000
然后你就可以看到你的博客啦

## 将博客发布到github

> Gitup创建博客仓库

仓库名必须为【${your_user_name}.github.io】，例如你的github用户名叫做zhangsan，那个这个仓库名就叫zhangsan.github.io，建立好仓库之后就是在github上发布个人主页，这里不再细述，具体操作可以百度

> 生成静态页面

我们之前通过new方法来创建了一个新的博客，但是并么有生成可以直接通过浏览器访问的静态页面文件，所以要通过以下命令来将我们的博客转换成web静态文件
```bash
hexo generate
```
执行命令后默认会将生成的静态文件放在public文件夹下

> 关联发布至github.io

首先需要配置_config.yml文件来关联git仓库,任意编译器打开_config.yml找到deploy这里，改成以下配置(注意： 冒号后面要有空格！)
```yml
deploy:
  type: git
  respository: ${your git blog web URL}
  branch: master
```

> 发布至github.io

```bash
hexo deploy
```
这样就会将你的public文件夹上传到github.io的仓库里，再打开你的github.io的地址就可以看到你的博客。

## 个性化你的HEXO博客
HEXO提供很多的主题，可以根据自己的需要来选择相应的主题风格，安装方法也很简单，这里贴上官方文档供大家阅读 [hexo | themes](https://hexo.io/themes/)

## 参考链接

#### [HEXO](https://hexo.io/)

#### [HEXO | THEMES](https://hexo.io/themes/)

#### [github](https://github.com/)

#### [NODE](http://nodejs.cn/)
#### [markdown](http://www.appinn.com/markdown/basic.html)
