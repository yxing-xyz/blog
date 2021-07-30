# MySQL

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
