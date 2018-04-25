#sql 优化

1. 任何在where子句中使用`is null`或`is not null`的语句优化器是不允许使用索引的。
2. 模糊查询使用索引

    ```sql
    SELECT * FROM table WHERE name LIKE 'abc%'

    下面这条不会使用索引
    SELECT * FROM table WHERE name LIKE '%abc%'
    ```

3. 避免使用'*'
4. 通过内部函数提高SQL效率
5. 使用表别名
6. 用EXISTS替代IN, NOT EXISTS替代NOTIN

    ```sql
    insert into A (name,age) select name,age from B where not exists (select 1 from A where A.id=B.id);
    select * from A where exists (select 1 from B where A.id=B.id)
    ```
7. 避免在索引列上使用计算

    ```sql
    SELECT a FROM table WHERE TT * 12 > 5000; 索引会失效
    SELECT a FROM table WHERE TT > 5000/12;
    ```
