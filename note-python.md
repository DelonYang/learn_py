常用包和函数：
1. itertools
    1. chain
        ```python
        test_list = [[1,2],[3,4]]
        chain.from_iterable(test_list)
        chain(*test_list)
        ```
2. 使用and or 代替三目运算
    ```python
    1 == 1 and a or b
    1 == 2 and a or b
    ```
3. pyftpdlib
    一行命令开启ftp服务，在需要共享的目录使用该命令：`python - m pyftpdlib -p 21`

4.
