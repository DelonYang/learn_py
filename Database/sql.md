# sql基本语法

### alter
    ```sql
    --1. 添加新字段
    ALTER TABLE table_name ADD COLUMN order_id  INT(11) NOT NULL AFTER column;
    --2. 添加索引
    ALTER TABLE table_name ADD INDEX order_id(order_id);
    --3. 添加外键约束
    ALTER TABLE table_name ADD CONSTRAINT hash_profit_ibfk_3 foreign key(order_id) REFERENCES star_contract_order(id)
    --4. 设置自增id从n开始，n为下次添加时的值
    ALTER TABLE table_name AUTO_INCREMENT=n
    --5. 添加主键
    ALTER TABLE table_name ADD PRIMARY KEY ( `column` )
    --6. 添加唯一索引
    ALTER TABLE `table_name` ADD UNIQUE (`column`)

    --修改字段类型
    ALTER TABLE table_name MODIFY COLUMN column int;
    ALTER TABLE table_name CHANGE old_name new_name int;

    --删除字段
    ALTER TABLE table_name DROP field;
    ```

    ```sql
    --1. 导入导出
    mysqldump -hhostname -uusername -ppassword databasename > backupfile.sql
    mysql -hhostname -uusername -ppassword databasename < backupfile.sql

    --1. 用户授权
    GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' IDENTIFIED BY 'youpassword' WITH GRANT OPTION; 
    FLUSH PRIVILEGES; 

    --1. 复制表
    CREATE TABLE 新表 SELECT * FROM 旧表 会连同数据一起复制
    CREATE TABLE 新表 SELECT * FROM 旧表 WHERE 1=2 只复制表结构
    ```