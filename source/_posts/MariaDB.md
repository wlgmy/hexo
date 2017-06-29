---
title: MariaDB
date: 2017-06-27 17:34:40
tags:
---

## 简述

本文基于centos7.3版本简单介绍安装、配置、使用MariaDB数据库。MariaDB是一个增强的MySql替代品，由于MySql已被sun公司收购，因此在阿里云上的centos服务器标配MariaDB数据库。

## 安装
``` bash
yum -y install mariadb mariadb-server
```
## 简单配置
> 启动

``` bash
systemctl start mariadb
```

> 开机启动

``` bash
systemctl enable mariadb
```

> 一些简单的相关配置

```bash
mysql_secure_installation
```
进入设置，首先是设置密码，初始密码为空，直接回车跳过即可
```bash
# 是否设置root用户密码
Set root password? [Y/n]
New password:
Re-enter new password:

# 是否删除匿名用户
Remove anonymous users? [Y/n]

#是否禁止root远程登录
Disallow root login remotely? [Y/n]

# 是否删除test数据库
Remove test database and access to it? [Y/n]

# 是否重新加载权限表
Reload privilege tables now? [Y/n]
```

> 登录

```bash
mysql -u`root` -p`password`
```

> 设置字符集
修改 /etc/my.cnf文件
```bash
vi /etc/my.cnf
```
在[mysqld]标签下添加
```bash
init_connect='SET collation_connection = utf8_unicode_ci'
init_connect='SET NAMES utf8'
character-set-server=utf8
collation-server=utf8_unicode_ci
skip-character-set-client-handshake
```
修改/etc/my.cnf.d/client.cnf文件
在[client]中添加
```bash
default-character-set=utf8
```
修改/etc/my.cnf.d/mysql-clients.cnf文件
在[mysql]中添加
```bash
default-character-set=utf8
```
配置结束，重启MariaDB并检查字符集
```bash
#重启
systemctl restart mariadb
#登录
mysql -u`root` -p`password`
#查看字符集
show variables like "%character%";show variables like "%collation%";
```

## 用户和权限相关
> 创建用户

```bash
create user username@localhost identified by 'password';
```
> 直接创建用户并授权

```bash
grant all on *.* to username@localhost indentified by 'password';
```

> 授予外网登陆权限

```bash
grant all privileges on *.* to username@'%' identified by 'password';
```

> 授予权限并且可以授权

```bash
grant all privileges on *.* to username@'hostname' identified by 'password' with grant option;
```

## mac客户端测试远程连接
> 安装MariaDB

```bash
brew install MariaDB
```

> 测试连接

```bash
 mysql -u username -h hostname --port port -p
```
