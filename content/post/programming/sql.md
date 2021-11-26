---
title: "SQL"
date: 2021-11-26T21:27:00+08:00
lastmod: 2021-11-26T21:47:00+08:00
draft: false
categories:
  - "Programming"
tags:
  - "Syntax"
  - "SQL"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'

# MySQL

## 预编译批量插入
当预编译批量插入的时候数据量太大MySQL服务器会报错, 还是直接拼values的sql吧
```bash
Error 1390: Prepared statement contains too many placeholders
```

## 查询所有数据库占用空间

```sql
SELECT table_schema,
       concat(TRUNCATE(SUM(data_length) /1024/1024, 2), ' MB')  AS data_size,
       concat(TRUNCATE(SUM(index_length) /1024/1024, 2), 'MB')  AS index_size
  FROM information_schema.tables
 GROUP BY table_schema
 ORDER BY data_length DESC;
```

## 查询某一个数据库表占用空间
```sql
SELECT table_name, concat(TRUNCATE(data_length/1024/1024,2),' MB') AS data_size,
concat(TRUNCATE(index_length/1024/1024,2),' mb') AS index_size
FROM information_schema.tables WHERE table_schema = '${database}'
GROUP By table_name
ORDER BY data_length DESC;
```
