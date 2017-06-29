---
title: 常用mysql命令
date: 2017-06-28 11:12:29
tags:
---
> 登录

```bash
 mysql -u username -h hostname --port port -p
```

> 查看数据库

```bash
SHOW DATABASES;
```

> 创建数据库

```bash
CREATE DATABASE database;
```
> 选择目标数据库

```bash
USE database;
```
> 查看数据表和新建数据表

```bash
# 查看数据表
SHOW TABLES;
# 新建数据表
CREATE TABLE mytable (name VARCHAR(20), sec CHAR(1));
```
# 显示表结构
```bash
DESCRIBE mytable;
```
